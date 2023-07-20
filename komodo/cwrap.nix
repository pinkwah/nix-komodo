{ buildPythonPackage, pythonPackages, pkgs, ... }:

buildPythonPackage rec {
  pname = "cwrap";
  version = "1.6.5";

  src = pkgs.fetchFromGitHub {
    owner = "equinor";
    repo = pname;
    rev = version;
    hash = "sha256-X/DLOKiov0BwXRZfYtqSMSkxP5I7MOcy4gfcBaEsgbg";
  };

  doCheck = false;

  propagatedBuildInputs = with pythonPackages; [
    six
  ];

  SETUPTOOLS_SCM_PRETEND_VERSION = version;
}
