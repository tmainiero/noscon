# Interceptions tools module

# Uses my custom interception-tools-plugins
## Current mappings:
### CAPS swapped with ESC (capstoesc): NOT the same as caps2esc!
### RCTRL swapped with SUPER (rightctrltosuper)
### ENTER acts as RCTRL when held, ENTER when tapped (enter+rightctrl)

## Broken/Unused mappings
### MENU swapped with SUPER (menutosuper): DOES NOT WORK!

{ config, lib, pkgs, ... }:

let
  cfg = config.my.interception-tools;
  interception-tools = pkgs.interception-tools;
  my-plugins = pkgs.callPackage ../../packages/interception-tools-plugins { };
in {
  options.my.interception-tools = {
    enable = lib.mkEnableOption "Interception tools (key remapping)";
  };

  config = lib.mkIf cfg.enable {
    services.interception-tools.enable = true;
    services.interception-tools.plugins = [ my-plugins ];

    # Full paths to executables needed to work properly
    services.interception-tools.udevmonConfig = ''
      - JOB: "${interception-tools}/bin/intercept -g $DEVNODE \
      | ${my-plugins}/bin/capstoesc \
      | ${my-plugins}/bin/rightctrltosuper \
      | ${my-plugins}/bin/enter+rightctrl \
      | ${interception-tools}/bin/uinput -d $DEVNODE"
        DEVICE:
          EVENTS:
            EV_KEY: [KEY_CAPSLOCK, KEY_ESC, KEY_RIGHTCTRL, KEY_RIGHTMETA, KEY_ENTER]
    '';
  };
}
