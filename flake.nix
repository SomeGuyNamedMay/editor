{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }: flake-utils.lib.eachDefaultSystem (system: 
  let pkgs = nixpkgs.legacyPackages.${system};
  in {
    packages.hello = pkgs.hello;
    packages.default = self.packages.${system}.hello;
    devShell = pkgs.mkShell {
      packages = with pkgs; [
        cargo
        rust-analyzer
        rustfmt
        lldb
      ];
    };
  });
}
