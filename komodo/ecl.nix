{ cwrap, pythonPackages, buildPythonPackage, fetchPypi, ... }:

buildPythonPackage rec {
  pname = "ecl";
  version = "2.14.3";
  format = "wheel";

  src = fetchPypi {
    inherit pname version format;
    dist = "cp310";
    python = "cp310";
    abi = "cp310";
    platform = "manylinux_2_17_x86_64.manylinux2014_x86_64";
    hash = "sha256-bvrcrau3VvZbs4nspS4SQeUx09+mBybKP0Jc9F7DQ6I=";
  };

  dontUseCmakeConfigure = true;

  doCheck = false;

  propagatedBuildInputs = with pythonPackages; [
    numpy
    pandas
  ] ++ [cwrap];

  SETUPTOOLS_SCM_PRETEND_VERSION = version;
}
