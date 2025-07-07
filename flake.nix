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
    system = "x86_64-linux";

    lib = nixpkgs.lib;

    hm-config = {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.cornholio.imports = [ ./home.nix ];
    };

    allowed-unfree-packages = [
      "zoom-us"
    ];

  in {
    nixosConfigurations = {
      kuato = lib.nixosSystem {
        inherit system;
        modules = [ 
          ./configuration.nix 
          home-manager.nixosModules.home-manager hm-config
        ];
      };
    };
  };
}
