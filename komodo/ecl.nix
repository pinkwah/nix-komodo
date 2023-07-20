{ cwrap, pythonPackages, buildPythonPackage, fetchFromGitHub, cmake, ninja, conan1, which, ... }:

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

  nativeBuildInputs = with pythonPackages; [
    scikit-build
  ] ++ [
    cmake
    ninja
    conan1
  ];

  propagatedBuildInputs = with pythonPackages; [
    numpy
    pandas
  ] ++ [cwrap];

  preConfigure = ''
    export CONAN_USER_HOME=$(mktemp -d)
    echo ">>> $(${which}/bin/which conan)"
    conan --version
    unset PYTHONPATH
  '';

  SETUPTOOLS_SCM_PRETEND_VERSION = version;
}
