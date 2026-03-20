# Udiskie
{ config, lib, pkgs, ... }:

let cfg = config.my.udiskie;
in {
  options.my.udiskie = {
    enable = lib.mkEnableOption "Udiskie (automount)";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      udiskie
    ];

    # Automount with pcmanfm (still failing)
    services.udisks2.enable = true;
    services.gvfs.enable = true;
    services.devmon.enable = true;
  };
}
