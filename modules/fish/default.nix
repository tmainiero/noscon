{ config, lib, ... }:

let cfg = config.my.fish;
in {
  options.my.fish = {
    enable = lib.mkEnableOption "Fish shell";
  };

  config = lib.mkIf cfg.enable {
    programs.fish.enable = true;
  };
}
