{ config, pkgs, lib, ... }:

{
  # See https://nixos.wiki/wiki/IOS (March 2024)
  config = {
    environment.systemPackages = with pkgs; [
      libimobiledevice
      ifuse # mount using `ifuse`
    ];
    services.usbmuxd = {
      enable = true;
      package = pkgs.usbmuxd2;
    };
  };
}
