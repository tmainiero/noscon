# Picom configuration
{ config, lib, ... }:

let cfg = config.my.picom;
in {
  options.my.picom = {
    enable = lib.mkEnableOption "Picom compositor";

    cornerRadius = lib.mkOption {
      type = lib.types.float;
      default = 8.0;
      description = "Corner radius for rounded corners.";
    };

    backend = lib.mkOption {
      type = lib.types.str;
      default = "glx";
      description = "Rendering backend (glx or xrender).";
    };
  };

  config = lib.mkIf cfg.enable {
    services.picom.enable = true;
    services.picom.settings = {
      # Animations
      transition-length = 20;
      transition-pow-x = 0.5;
      transition-pow-y = 0.5;
      transition-pow-w = 0.5;
      transition-pow-h = 0.5;
      size-transition = true;

      # Rounded corners
      corner-radius = cfg.cornerRadius;
      rounded-corners-exclude = [
        "class_g = 'Zathura'"
        "class_g = 'dmenu'"
        "class_g = 'Rofi'"
        "class_g = 'Dunst'"
        "name    = 'xmobar'"
      ];
      round-borders = 1;

      # Blurring
      blur = {
        method = "dual_kawase";
        strength = 0;
        background = false;
        background-frame = false;
        background-fixed = false;
        kern = "3x3box";
      };

      blur-background-exclude = [
        "class_g = 'slop'"
        "class_g = 'Alacritty'"
        "class_g = 'Rofi'"
        "_GTK_FRAME_EXTENTS@:c"
      ];

      backend = cfg.backend;
    };
  };
}
