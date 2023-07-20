{ cwrap, autoconf, perl, pythonPackages, buildPythonPackage, gnum4
, fetchFromGitHub, cmake, ninja, conan, which, roffio, ecl-data-io, swig, ... }:

buildPythonPackage rec {
  pname = "xtgeo";
  version = "3.1.2";

  src = fetchFromGitHub {
    owner = "equinor";
    repo = pname;
    rev = version;
    hash = "sha256-Mtu32nzHvBPM1xwwPFlDh/ssfx+w2c4elpSftqo7X7M=";
  };

  dontUseCmakeConfigure = true;

  doCheck = false;

  nativeBuildInputs = [ pythonPackages.scikit-build cmake ninja swig ];

  propagatedBuildInputs = with pythonPackages; [
    deprecation
    numpy
    shapely
    matplotlib
    scipy
    segyio
    pandas
    h5py
    hdf5plugin
    tables
    ecl-data-io
    typing-extensions
    roffio
  ];

  SETUPTOOLS_SCM_PRETEND_VERSION = version;

  # Remove all requirement files
  preConfigure = ''
    echo > requirements/requirements_setup.txt
  '';
}
