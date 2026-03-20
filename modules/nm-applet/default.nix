{ config, lib, ... }:

let cfg = config.my.nm-applet;
in {
  options.my.nm-applet = {
    enable = lib.mkEnableOption "NetworkManager applet";
  };

  config = lib.mkIf cfg.enable {
    programs.nm-applet.enable = true;
  };
}
