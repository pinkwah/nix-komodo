{ pkgs, conan1, cmake, buildPythonPackage, fetchFromGitHub, ... }:

let
  name = "ecl";
  version = "2.14.3";
in buildPythonPackage {
  pname = name;
  version = version;
  format = "setuptools";

  src = fetchFromGitHub {
    owner = "equinor";
    repo = name;
    rev = "main";
    hash = "sha256-tZQOl43ROCCi0MYWbv0jEavL1DeF0e0UEpJDbvK10wY";
  };

  dontUseCmakeConfigure = true;

  doCheck = false;

  nativeBuildInputs = [
    pkgs.python3Packages.scikit-build
    cmake
    conan1
  ];

  SETUPTOOLS_SCM_PRETEND_VERSION = version;
}
