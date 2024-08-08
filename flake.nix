{
  description = "My collection of nix packages.";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default";

    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ flake-parts, systems, snowfall-lib, ... }:
    # flake-parts.lib.mkFlake { inherit inputs; } {
    #   systems = import systems;
    #
    #   imports = [
    #     inputs.flake-parts.flakeModules.easyOverlay
    #     ./imports/overlay.nix
    #     ./imports/formatter.nix
    #     ./imports/pkgs-by-name.nix
    #     ./imports/pkgs-all.nix
    #   ];
    # };
    snowfall-lib.mkFlake {
      inherit inputs;
      src = ./.;

      snowfall = {
        root = ./.;

        namespace = "my-test";

        meta = {
          name = "my-test";
          title = "My test";
        };
      };
    };
}
