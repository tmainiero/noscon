# Picom configuration
{config, lib, pkgs, ...}:
{
  config = {
    services.picom.enable = true;
    services.picom.settings =
      {
      # Animations
      transition-length=20;
      transition-pow-x = 0.5;
      transition-pow-y = 0.5;
      transition-pow-w = 0.5;
      transition-pow-h = 0.5;
      size-transition = true;

      # Rounded corners
      corner-radius = 8.0;
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
        #method = "kernel";
        strength = 0;
        # deviation = 1.0;
        # kernel = "11x11gaussian";
        background = false;
        background-frame = false;
        background-fixed = false;
        kern = "3x3box";
      };

      blur-background-exclude = [
        #"window_type = 'dock'",
        #"window_type = 'desktop'",
        # prevents picom from blurring the background
        # when taking selection screenshot with `main`
        # https://github.com/naelstrof/maim/issues/130
        "class_g = 'slop'"
        "class_g = 'Alacritty'"
        "class_g = 'Rofi'"
        "_GTK_FRAME_EXTENTS@:c"
      ];

      backend = "glx";
    };
  };
}
