{ nixpkgs, home-manager }:

{ host, user, homeModule ? null, overlays ? [] }:

let
  lib = nixpkgs.lib;

  hmModules = lib.optionals (homeModule != null) [
    home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.extraSpecialArgs = { inherit user; };
      home-manager.users.${user} = {
        imports = [ homeModule ];
        home.username = user;
        home.homeDirectory = "/home/${user}";
      };
    }
  ];

in
lib.nixosSystem {
  system = "x86_64-linux";
  specialArgs = { inherit user; };
  modules = [
    { nixpkgs.overlays = overlays; }
    ../hosts/${host}
    ../configuration.nix
  ] ++ hmModules;
}
