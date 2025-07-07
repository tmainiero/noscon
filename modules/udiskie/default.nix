# Udiskie
{config, lib, pkgs, ...}:
{
  config = {
    environment.systemPackages = with pkgs; [
      udiskie
    ];

  # Automount with pcmanfm (still failing)
  services.udisks2.enable = true;
  services.gvfs.enable = true;
  services.devmon.enable = true;
  };
}
