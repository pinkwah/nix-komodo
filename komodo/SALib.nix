{ pythonPackages, buildPythonPackage, fetchurl, ... }:

buildPythonPackage rec {
  pname = "SALib";
  version = "1.4.7";
  format = "wheel";

  src = fetchurl {
    url =
      "https://files.pythonhosted.org/packages/d1/51/1170274c6cc5302d553cb1c1072c4612aff0e9dcd80821f88d8954e1a4be/salib-1.4.7-py3-none-any.whl";
    hash = "sha256-0EZX2aSXK1bKNKwPCxEo8h5GTVBYkq2/kh7HDyBmLoQ=";
  };

  doCheck = false;

  propagatedBuildInputs = with pythonPackages; [
    numpy
    scipy
    matplotlib
    pandas
    multiprocess
  ];
}
