{ config, lib, pkgs, ... }:

let cfg = config.my.distrobox;
in {
  options.my.distrobox = {
    enable = lib.mkEnableOption "Distrobox";

    backend = lib.mkOption {
      type = lib.types.enum [ "docker" "podman" ];
      default = "docker";
      description = "Container backend for distrobox.";
    };
  };

  config = lib.mkIf cfg.enable {
    my.docker.enable = lib.mkDefault (cfg.backend == "docker");
    my.podman.enable = lib.mkDefault (cfg.backend == "podman");

    environment.systemPackages = with pkgs; [
      distrobox
      xhost
    ];

    # Keep X from blocking access to containers
    # https://github.com/NixOS/nixpkgs/issues/208817
    environment.shellInit = ''
      [ -n "$DISPLAY" ] && xhost +si:localuser:$USER || true
    '';

    # Add ~/.local/bin to $PATH for simple distrobox export:
    environment.localBinInPath = true;
  };
}
