{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./misc-setup.nix
  ];

  networking.hostName = "kuato";

  # Module enables (opt-in per host)
  my.neovim-system.enable      = true;
  my.xmonad.enable             = true;
  my.fish.enable               = true;
  my.distrobox.enable          = true;
  my.texlive.enable            = true;
  my.interception-tools.enable = true;
}
