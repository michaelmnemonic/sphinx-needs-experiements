{
  description = "Nix configuration for experiements with sphinx-needs";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    # Define 'forAllSystems' for properties that shall be build for x86_64 *and* aarch64
    systems = ["x86_64-linux" "aarch64-linux"];
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    devShell = forAllSystems (system: let
      pkgs = nixpkgs.legacyPackages.${system}.pkgs;
    in
      pkgs.mkShell {
        buildInputs = [
          pkgs.gitMinimal
          pkgs.nil
          pkgs.alejandra
          (pkgs.python3.withPackages (python-pkgs: [
            python-pkgs.sphinx
          ]))
        ];
      });
  };
}
