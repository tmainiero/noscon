{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./misc-setup.nix
  ];

  networking.hostName = "stultiloquator";

  # Module enables (opt-in per host)
  my.neovim-system.enable      = true;
  my.xmonad.enable             = true;
  my.fish.enable               = true;
  my.distrobox.enable          = true;
  my.distrobox.backend         = "podman";
  my.texlive.enable            = true;
  my.interception-tools.enable = true;
  my.virt-manager.enable       = true;

  # Touchpad (laptop)
  services.libinput = {
    enable = true;
    touchpad = {
      tapping = false;
      disableWhileTyping = true;
    };
  };
}
