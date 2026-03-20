{ config, lib, pkgs, ... }:

let cfg = config.my.systemtray;
in {
  options.my.systemtray = {
    enable = lib.mkEnableOption "System tray (trayer)";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      trayer
    ];
  };
}
