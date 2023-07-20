let
  nixpkgs = import <nixpkgs> {};
  allPkgs = nixpkgs // pkgs;
  callPackage = path: overrides:
    let f = import path;
    in f ((builtins.intersectAttrs (builtins.functionArgs f) allPkgs) // overrides // kmdLib);

  kmdLib = with nixpkgs; {
    pythonPackages = python3Packages;
    buildPythonPackage = python3Packages.buildPythonPackage;
    buildPythonApplication = python3Packages.buildPythonApplication;
  };

  pkgs = with nixpkgs; {
    # conan1 = callPackage ./komodo/conan1.nix {};
    cwrap = callPackage ./komodo/cwrap.nix {};
    ecl = callPackage ./komodo/ecl.nix {};
  };
in {
  version = "bleeding";

  komodoPackages = pkgs;

  release = nixpkgs.mkShell {
    packages = nixpkgs.lib.attrValues pkgs;
  };
}
