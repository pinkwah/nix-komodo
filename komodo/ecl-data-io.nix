{ pythonPackages, buildPythonPackage, fetchurl, ... }:

buildPythonPackage rec {
  pname = "ecl-data-io";
  version = "3.1.0";
  format = "wheel";

  src = fetchurl {
    url =
      "https://files.pythonhosted.org/packages/47/6a/a20c6ab2f623a354b85696a1eb235c90232da276e2b37c9ad0c4794ef101/ecl_data_io-3.1.0-py3-none-any.whl";
    hash = "sha256-TdObLfu0EM+UG3m2XzzPTGc4LWVdCOiufSGc9Tq8NQk=";
  };

  doCheck = false;

  propagatedBuildInputs = with pythonPackages; [ numpy ];

  SETUPTOOLS_SCM_PRETEND_VERSION = version;
}
