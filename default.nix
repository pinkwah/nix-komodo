let
  nixpkgs = import <nixpkgs> {};
  allPkgs = nixpkgs // pkgs;
  callPackage = path: overrides:
    let f = import path;
    in f ((builtins.intersectAttrs (builtins.functionArgs f) allPkgs) // overrides);

  pkgs = with nixpkgs; {
    pythonPackages = python3Packages;
    buildPythonPackage = python3Packages.buildPythonPackage;

    conan1 = callPackage ./komodo/conan1.nix {};
    cwrap = callPackage ./komodo/cwrap.nix {};
    ecl = callPackage ./komodo/ecl.nix {};
  };
in {
  version = "bleeding";

  release = pkgs;
}
