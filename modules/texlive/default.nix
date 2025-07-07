{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # TeX: Everything
    # https://nixos.wiki/wiki/TexLive
    texlive.combined.scheme-full
  ];
}
