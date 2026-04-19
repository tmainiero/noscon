{
  description = "A nixOS/home-manager configuration 'in progress'";

  # Flake references used to build NixOS setup; these are dependencies
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    claude-code.url = "github:sadjow/claude-code-nix";
    claude-code.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, claude-code, ... }:
  let
    mkHost = import ./lib/make-host.nix { inherit nixpkgs home-manager; };
    overlays = [
      claude-code.overlays.default
      (import ./overlays/pkgs.nix)
    ];
  in {
    nixosConfigurations = {
      kuato = mkHost {
        host = "kuato";
        user = "cornholio";
        homeModule = ./home.nix;
        inherit overlays;
      };
      stultiloquator = mkHost {
        host = "stultiloquator";
        user = "cornholio";
        homeModule = ./home.nix;
        inherit overlays;
      };
    };
  };
}
