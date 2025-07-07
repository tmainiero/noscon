# Pasystray
{config, lib, pkgs, ...}:
{
  imports = [
    ../systemtray
  ];

  config = {
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
