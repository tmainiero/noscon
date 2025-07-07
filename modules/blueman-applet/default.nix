{ config, pkgs, ... }:

{
  config = {
    services.blueman.enable = true;

    # Inspired by the home-manager config
    # https://github.com/nix-community/home-manager/blob/master/modules/services/blueman-applet.nix#L29
    # systemd.user.services.blueman-applet = {
    #   description = "Blueman applet";
    #   wantedBy = ["graphical-session.target"];
    #   after = [ "graphical-session-pre.target"];
    #   partOf = [ "graphical-session.target" ];

    #   serviceConfig = {
    #     ExecStart = [ "${pkgs.blueman}/bin/blueman-applet" ]; 
    #     RestartSec = 3;
    #     Restart = "always";
    #   };
    # };
  };
}
