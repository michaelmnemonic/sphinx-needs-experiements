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
    pkgs = forAllSystems (system: nixpkgs.legacyPackages.${system});
  in {
    packages = forAllSystems (system: {
      sphinxcontrib-needs = pkgs.${system}.python3Packages.buildPythonPackage rec {
        pname = "sphinxcontrib-needs";
        version = "5.1.0";
        pyproject = true;

        src = pkgs.${system}.fetchPypi {
          pname = "sphinx_needs";
          inherit version;
          hash = "sha256-I6DKHf5zOgpY6IS1nOU6i2OlMPCsh65asNQPBfhT++c=";
        };

        nativeBuildInputs = [ pkgs.${system}.python3Packages.flit-core ];

        dontCheckRuntimeDeps = true;
        doCheck = false;
      };
      sphinxcontrib-data-viewer = pkgs.${system}.python3Packages.buildPythonPackage rec {
        pname = "sphinxcontrib-data-viewer";
        version = "0.1.5";
        pyproject = true;

        src = pkgs.${system}.fetchPypi {
          pname = "sphinx_data_viewer";
          inherit version;
          hash = "sha256-p9XlhhNWK7dFOAv+YcqLaZl5mBZ/1vqa6lVgbJpLF+Q=";
        };

        nativeBuildInputs = [ pkgs.${system}.python3Packages.flit-core ];

        dontCheckRuntimeDeps = true;
        doCheck = false;
      };
    });

    devShells = forAllSystems (system: {
      default = pkgs.${system}.mkShell {
        buildInputs = with pkgs.${system}; [
          gitMinimal
          nil
          alejandra
          self.packages.${system}.sphinxcontrib-needs
          self.packages.${system}.sphinxcontrib-data-viewer
          (python3.withPackages (python-pkgs: [
            python-pkgs.sphinx
            python-pkgs.jsonschema
            python-pkgs.requests-file
            python-pkgs.sphinxcontrib-jquery
          ]))
        ];
      };
    });
  };
}
