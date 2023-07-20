{
  description = "Komodo";

  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    nixpkgs-conan1.url = "nixpkgs/nixos-22.11";
  };

  outputs = { self, nixpkgs, nixpkgs-conan1 }:
    let
      lib = nixpkgs.lib.extend (final: prev: with nixpkgs.legacyPackages.x86_64-linux; {
        pythonPackages = python3Packages;
        buildPythonPackage = python3Packages.buildPythonPackage;
        buildPythonApplication = python3Packages.buildPythonApplication;
      });

      callPackage = path: overrides:
        let f = import path;
        in f ((builtins.intersectAttrs (builtins.functionArgs f) allPkgs) // overrides // lib);

      allPkgs = nixpkgs.legacyPackages.x86_64-linux // pkgs;

      pkgs = rec {
          cwrap = callPackage ./komodo/cwrap.nix {};
          ecl = callPackage ./komodo/ecl.nix {
            conan1 = nixpkgs-conan1.legacyPackages.x86_64-linux.conan;
          };
          default = (nixpkgs.legacyPackages.x86_64-linux.python3.withPackages (_: [ecl]));
      };
    in {
      packages.x86_64-linux = pkgs;
    };
}
