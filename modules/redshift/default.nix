# Redshift
{ config, lib, ... }:

let cfg = config.my.redshift;
in {
  options.my.redshift = {
    enable = lib.mkEnableOption "Redshift (color temperature)";

    latitude = lib.mkOption {
      type = lib.types.float;
      default = 40.713051;
      description = "Latitude for location provider.";
    };

    longitude = lib.mkOption {
      type = lib.types.float;
      default = -74.007233;
      description = "Longitude for location provider.";
    };

    temperature = {
      day = lib.mkOption {
        type = lib.types.int;
        default = 6500;
        description = "Daytime color temperature.";
      };

      night = lib.mkOption {
        type = lib.types.int;
        default = 2000;
        description = "Nighttime color temperature.";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    services.redshift = {
      enable = true;
      brightness = {
        day = "1";
        night = "1";
      };
      temperature = {
        day = cfg.temperature.day;
        night = cfg.temperature.night;
      };
    };

    location.provider  = "manual";
    location.latitude  = cfg.latitude;
    location.longitude = cfg.longitude;
  };
}
