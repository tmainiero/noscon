# Pasystray
{ config, lib, pkgs, ... }:

let cfg = config.my.pasystray;
in {
  options.my.pasystray = {
    enable = lib.mkEnableOption "PulseAudio system tray applet";
  };

  config = lib.mkIf cfg.enable {
    my.systemtray.enable = true;

    environment.systemPackages = with pkgs; [
      pasystray
    ];

    ## No line `requires = [ "tray.target"]` due to:
    ## https://github.com/nix-community/home-manager/issues/2064
    systemd.user.services.pasystray = {
      description = "Audio system tray applet";
      wantedBy = ["graphical-session.target"];
      after = [ "graphical-session-pre.target"];
      partOf = [ "graphical-session.target" ];

      serviceConfig = {
        ExecStart = [ "${pkgs.pasystray}/bin/pasystray" ];
        RestartSec = 3;
        Restart = "always";
      };
    };
  };
}
