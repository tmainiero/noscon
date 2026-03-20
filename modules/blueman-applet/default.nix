{ config, lib, pkgs, ... }:

let cfg = config.my.blueman-applet;
in {
  options.my.blueman-applet = {
    enable = lib.mkEnableOption "Blueman applet";
  };

  config = lib.mkIf cfg.enable {
    services.blueman.enable = true;
  };
}
