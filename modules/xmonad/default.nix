# XMonad
# reference: https://gvolpe.com/blog/xmonad-polybar-nixos
{ config, lib, pkgs, ... }:

let cfg = config.my.xmonad;
in {
  options.my.xmonad = {
    enable = lib.mkEnableOption "XMonad window manager";

    wallpaperDir = lib.mkOption {
      type = lib.types.str;
      default = "$HOME/noscon/data/wallpaper/dark/*";
      description = "Glob pattern for wallpaper directory.";
    };

    terminal = lib.mkOption {
      type = lib.types.package;
      default = pkgs.alacritty;
      description = "Terminal emulator package.";
    };
  };

  config = lib.mkIf cfg.enable {
    # Cascade: enable sub-modules by default
    my.picom.enable          = lib.mkDefault true;
    my.redshift.enable       = lib.mkDefault true;
    my.udiskie.enable        = lib.mkDefault true;
    my.systemtray.enable     = lib.mkDefault true;
    my.pasystray.enable      = lib.mkDefault true;
    my.nm-applet.enable      = lib.mkDefault true;
    my.blueman-applet.enable = lib.mkDefault true;

    environment.systemPackages = with pkgs; [
      # Window Manager Necessities
      # X-server specific
      xclip

      # Terminal
      cfg.terminal

      # Appearance
      feh
      arandr

      # Notifications
      dunst

      # Screen Locker
      xscreensaver

      # Backlight control
      brightnessctl

      # Navigation
      dmenu
      rofi

      # Gui File Manager
      pcmanfm
    ];

    services.displayManager.defaultSession = "none+xmonad";
    services.xserver.enable = true; # Enable X11
    services.xserver.displayManager.sessionCommands = ''
      # Set background
      feh --no-fehbg --bg-scale --randomize ${cfg.wallpaperDir}
    '';

    services.xserver.windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      extraPackages = hpkgs: [
        hpkgs.xmobar

        # Development environment
        hpkgs.dbus
        hpkgs.List
        hpkgs.monad-logger
      ];
    };

    # Screenlocker
    services.xscreensaver.enable = true;


    services.xserver.xkb.layout = "us";

    services.libinput = {
      enable = true;
      touchpad = {
        tapping = false; # disable tap to click
        disableWhileTyping = true;
      };
    };

    # Fonts used in xmobar
    fonts.packages = with pkgs; [
      nerd-fonts.fira-code
      font-awesome
    ];

    services.dbus.enable = true;
    # Get system's power info/CPU usage
    services.upower.enable = true;
  };
}
