{ config, pkgs, lib, ... }:
{
  virtualisation.docker.enable = true;

  # Optional: Add your user to the "docker" group to run docker without sudo
  users.users.cornholio.extraGroups = [ "docker" ];

  # Temporary workaround for OCI permission error
  security.lsm = lib.mkForce [];
}
