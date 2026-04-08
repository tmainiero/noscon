{ ... }:

{
  # Suppress virt-manager connection nag on first launch
  # https://nixos.wiki/wiki/Virt-manager
  # Harmless when virt-manager is not installed.
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris        = [ "qemu:///system" ];
    };
  };
}
