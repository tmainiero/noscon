# Redshift
{config, lib, pkgs, ...}:
{
  config = {
    services.redshift = {
      enable = true;
      brightness = {
        day = "1";
        night = "1";
      };
      temperature = {
        day = 6500;
        night = 2000;
      };
    };

    ##############
    #  New York  #
    ##############
    location.provider  = "manual";
    location.latitude  = 40.713051;
    location.longitude = -74.007233;

    ########
    #  LA  #
    ########
    # location.provider  = "manual";
    # location.latitude  = 34.0549;
    # location.longitude = -118.2426;

    # Set location provider 
    # (stuck on "waiting for initial location..")
    # location.provider = "geoclue2";
    #services.geoclue2.enable = true;
    #services.geoclue2.appConfig.redshift.isAllowed = true;
  };
}
