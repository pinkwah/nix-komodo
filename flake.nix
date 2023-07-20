{
  description = "Komodo";

  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    nixpkgs-conan1.url =
      "github:nixos/nixpkgs/1e21c5807c4010c84c4628aab2af38a45c46c575";
  };

  outputs = { self, nixpkgs, nixpkgs-conan1 }:
    let
      lib = nixpkgs.lib.extend (final: prev:
        with nixpkgs.legacyPackages.x86_64-linux; {
          python = python3;
          pythonPackages = python3Packages;
          buildPythonPackage = python3Packages.buildPythonPackage;
          buildPythonApplication = python3Packages.buildPythonApplication;
        });

      callPackage = path: override:
        let f = import path;
        in f ((builtins.intersectAttrs (builtins.functionArgs f) allPkgs
          // override // extraPkgs) // lib);

      extraPkgs = { };

      allPkgs = nixpkgs.legacyPackages.x86_64-linux // pkgs;

      pkgs = rec {
        cwrap = callPackage ./komodo/cwrap.nix { };
        conan = callPackage ./komodo/conan.nix { };
        ecl = callPackage ./komodo/ecl.nix { };
        ert = callPackage ./komodo/ert.nix { };
        default = (nixpkgs.legacyPackages.x86_64-linux.python3.withPackages
          (_: [ ecl ert ]));
      };
    in {
      packages.x86_64-linux = pkgs;

      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt;
    };
}
