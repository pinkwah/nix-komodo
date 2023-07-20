{
  description = "Komodo";

  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    nixpkgs-conan1.url = "nixpkgs/nixos-22.11";
  };

  outputs = { self, nixpkgs, nixpkgs-conan1 }: {
    packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;
    packages.x86_64-linux.default = self.packages.x86_64-linux.hello;
    packages.x86_64-linux.conan = nixpkgs-conan1.legacyPackages.x86_64-linux.conan;
  };
}
