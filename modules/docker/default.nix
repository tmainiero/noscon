{ config, lib, pkgs, ... }:

let cfg = config.my.docker;
in {
  options.my.docker = {
    enable = lib.mkEnableOption "Docker virtualisation";

    user = lib.mkOption {
      type = lib.types.str;
      default = config.my.user.name;
      description = "User to add to the docker group.";
    };
  };

  config = lib.mkIf cfg.enable {
    virtualisation.docker.enable = true;

    # Add user to the "docker" group to run docker without sudo
    users.users.${cfg.user}.extraGroups = [ "docker" ];

    # Temporary workaround for OCI permission error
    security.lsm = lib.mkForce [];
  };
}
