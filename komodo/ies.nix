{ pythonPackages, buildPythonPackage, fetchurl, eigen, ... }:

buildPythonPackage rec {
  pname = "iterative-ensemble-smoother";
  version = "0.1.1";
  format = "pyproject";

  src = fetchurl {
    url =
      "https://files.pythonhosted.org/packages/8a/4a/92923a46afafc7aa9343e9e23c9aca417f12039b7896d8eea90eb11f8857/iterative_ensemble_smoother-0.1.1.tar.gz";
    hash = "sha256-S/my+xGcmG63jPZ7/E7VNF2LwU6e2HzppelVoovwHhw=";
  };

  doCheck = false;

  nativeBuildInputs = with pythonPackages; [ pybind11 eigen setuptools ];

  propagatedBuildInputs = with pythonPackages; [ numpy ];

  prePatch = ''
    echo "#!/usr/bin/env true" > conan
    chmod +x conan
    export PATH=$PWD:$PATH
    touch conanbuildinfo.args
    export CPATH="${eigen}/include/eigen3":$CPATH

    substituteInPlace pyproject.toml --replace 'dynamic=["version"]' 'version = "${version}"'
  '';

  SETUPTOOLS_SCM_PRETEND_VERSION = version;
}
