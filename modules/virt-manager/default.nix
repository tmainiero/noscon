{ config, lib, pkgs, user, ... }:

let cfg = config.my.virt-manager;
in {
  options.my.virt-manager = {
    enable = lib.mkEnableOption "virt-manager with libvirtd";
  };

  config = lib.mkIf cfg.enable {
    programs.virt-manager.enable = true;

    users.groups.libvirtd.members = [ user ];

    virtualisation.libvirtd.enable = true;
    virtualisation.spiceUSBRedirection.enable = true;
  };
}
