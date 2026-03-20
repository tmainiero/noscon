{ config, lib, pkgs, ... }:

let cfg = config.my.mount-ios-device;
in {
  options.my.mount-ios-device = {
    enable = lib.mkEnableOption "iOS device mounting";
  };

  # See https://nixos.wiki/wiki/IOS (March 2024)
  config = lib.mkIf cfg.enable {
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
