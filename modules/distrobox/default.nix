{config, lib, pkgs, ...}:

{
  imports = [
    # # Use podman as backend
    # ../podman

    # Use docker as backend
    ../docker
  ];

  config ={
    environment.systemPackages = with pkgs; [
      distrobox
      xorg.xhost
    ];

  # Keep X from blocking access to containers
  # https://github.com/NixOS/nixpkgs/issues/208817https://github.com/NixOS/nixpkgs/issues/208817
  environment.shellInit = ''
    [ -n "$DISPLAY" ] && xhost +si:localuser:$USER || true
  '';

  # Add ~/.local/bin to $PATH for simple distrobox export:
  environment.localBinInPath = true;
};
}
