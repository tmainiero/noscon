{ nixpkgs, home-manager }:

{ host, user, homeModule ? null }:

let
  lib = nixpkgs.lib;

  userModule = { config, lib, ... }: {
    options.my.user = {
      name = lib.mkOption {
        type = lib.types.str;
        description = "Primary user account name.";
      };
      homeDirectory = lib.mkOption {
        type = lib.types.str;
        default = "/home/${config.my.user.name}";
        description = "Home directory path.";
      };
    };
    config.my.user.name = user;
  };

  hmModules = lib.optionals (homeModule != null) [
    home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
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
  modules = [
    userModule
    ../hosts/${host}
    ../configuration.nix
  ] ++ hmModules;
}
