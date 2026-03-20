{
  description = "A nixOS/home-manager configuration 'in progress'";

  # Flake references used to build NixOS setup; these are dependencies
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
  let
    mkHost = import ./lib/make-host.nix { inherit nixpkgs home-manager; };
  in {
    nixosConfigurations = {
      kuato = mkHost { host = "kuato"; user = "cornholio"; homeModule = ./home.nix; };
    };
  };
}
