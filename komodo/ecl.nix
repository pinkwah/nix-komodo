{ cwrap, autoconf, perl, pythonPackages, buildPythonPackage, gnum4
, fetchFromGitHub, cmake, ninja, conan, which, ... }:

buildPythonPackage rec {
  pname = "ecl";
  version = "2.14.3";

  src = fetchFromGitHub {
    owner = "equinor";
    repo = pname;
    rev = version;
    hash = "sha256-CVxypCVIADDyw/Fs9CGVhOwjO+dk02/yauAN0bljVFg=";
  };

  dontUseCmakeConfigure = true;

  doCheck = false;

  nativeBuildInputs = with pythonPackages;
    [ scikit-build ] ++ [ autoconf perl cmake ninja ];

  propagatedBuildInputs = with pythonPackages; [ numpy pandas ] ++ [ cwrap ];

  prePatch = ''
    export CONAN_USER_HOME=$(mktemp -d)
    mkdir -p $CONAN_USER_HOME
    cat > $CONAN_USER_HOME/conan <<EOF
      #!/bin/sh
      unset PYTHONPATH
      export PYTHONPATH="${conan}/lib/python3.10/site-packages"
      exec "${conan}/bin/.conan-wrapped" "\$@"
    EOF
    chmod +x $CONAN_USER_HOME/conan
    export PATH=$CONAN_USER_HOME:$PATH

    substituteInPlace CMakeLists.txt --replace missing all
  '';

  SETUPTOOLS_SCM_PRETEND_VERSION = version;
}
