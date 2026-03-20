{ config, lib, pkgs, ... }:

let cfg = config.my.texlive;
in {
  options.my.texlive = {
    enable = lib.mkEnableOption "TeX Live (scheme-full)";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # TeX: Everything
      # https://nixos.wiki/wiki/TexLive
      texlive.combined.scheme-full
    ];
  };
}
