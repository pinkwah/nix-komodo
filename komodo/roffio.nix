{ pythonPackages, buildPythonPackage, fetchurl, ... }:

buildPythonPackage rec {
  pname = "RoffIO";
  version = "0.0.2";
  format = "wheel";

  src = fetchurl {
    url =
      "https://files.pythonhosted.org/packages/07/4c/71929e77baeb44c6121989d2b37e2df2c46ca77d8ceeb5bab809a73ac9ed/RoffIO-0.0.2-py3-none-any.whl";
    hash = "sha256-NKaRyNxlc6q0A+JXe5ScAL2b8u/okxHOCy2ZsOy7feM=";
  };

  doCheck = false;

  propagatedBuildInputs = with pythonPackages; [ numpy ];

  SETUPTOOLS_SCM_PRETEND_VERSION = version;
}
