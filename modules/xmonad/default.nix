# XMonad
# reference: https://gvolpe.comblog/xmonad-polbar-nixos
{config, lib, pkgs, ...}:

{
  imports = [
    ../picom
    ../redshift
    ../udiskie

    # System tray
    ../systemtray
    ../pasystray # volume indicator
    ../nm-applet # network manager
    ../blueman-applet   # blueman applet
  ];

  config = {
    environment.systemPackages = with pkgs; [

    # Window Manager Necessities
    # X-server specific 
    xclip

    #Terminal
    alacritty

    # Appearance
    feh
    arandr

    # Notifications
    dunst

    # Screen Locker
    xscreensaver

    # Navigation
    dmenu
    rofi
    # brotab

    # Gui File Manager
    pcmanfm
  ];

  services.displayManager.defaultSession = "none+xmonad";
  services.xserver.enable = true; # Enable X11
  services.xserver.displayManager.sessionCommands = ''
    # Set background
    feh --no-fehbg --bg-scale --randomize $HOME/noscon/data/wallpaper/dark/*
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
    # config = builtins.readFile ./xmonad.hs;
  };

  # Backlight control
  programs.light.enable = true;

  services.xserver.xkb.layout = "us"; 

  services.libinput = {
    enable = true;
    touchpad = {
      tapping = false; # disable tap to click
      disableWhileTyping = true;
    };
  };

  # Fonts used in xmobar
  fonts.packages= with pkgs; [
    nerd-fonts.fira-code
    font-awesome
  ];

  # Udiskie setup
  services.udisks2.enable = true;

  ## Automount with pcmanfm
  services.gvfs.enable = true;
  services.devmon.enable = true;

  services.dbus.enable = true; 
  # Get system's power info/CPU usage
  services.upower.enable=true;    

};

}
