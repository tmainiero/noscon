{ config, pkgs, lib, ... }:

{
  imports =
    [
      ./modules
    ];

  # Unfree packages allowed (Zoom); sorry Richard
  nixpkgs.config.allowUnfree = true;

  # Use the systemd-boot EFI boot loader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 5;

  networking.networkmanager.enable = true;

  time.timeZone = "America/New_York";
  # time.timeZone = "America/Los_Angeles";

  # Internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Power-saving/thermal measures
  services.thermald.enable = true;
  services.tlp.enable = true;             # auto-cpufreq is another option
  powerManagement.powertop.enable = true; # enables usb auto-suspend

  # Sound
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  hardware.bluetooth.enable = true;

  # Printing
  services.printing.enable = true;

  users.users.${config.my.user.name} = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"  # enable sudo
      "video"  # for brightness control
    ];     
    shell = pkgs.fish;
  };
  
  environment.systemPackages = with pkgs; [
    # Utilities
    wget
    git
    htop
    psmisc

    # File Management
    zip
    unzip
    xarchiver

    # Command-Line tools
    fzf
    any-nix-shell # Use the default shell (MODULARIZE WITH SHELL)
    comma # nix-shell -p on steroids

    # File Manager
    lf

    # Visualize nix dependencies
    # nix-tree

    # Video conferencing
    zoom-us
    # teams-for-linux

    # Security
    gitleaks
  ];

  services.xserver.displayManager.lightdm.enable = true;

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  programs.zsh.enable = true;

  xdg.mime = {
    enable = true;
    defaultApplications = {
      "inode/directory" = "pcmanfm.desktop";
    };
  };

  programs.nh = {
    enable = true;
    flake = "${config.my.user.homeDirectory}/noscon";
   # clean.enable = false; 
   # clean.extraArgs = "--keep-since 50d" --keep 3"
  };

  nix = {
    package      = pkgs.nixVersions.stable;
    settings     = {
      auto-optimise-store = true;
    };
    extraOptions = "experimental-features = nix-command flakes";
    gc = {
      automatic  = true;
      dates      = "weekly";
      options    = "--delete-older-than 50d";
    };
  };

  system.stateVersion = "23.05";
}
