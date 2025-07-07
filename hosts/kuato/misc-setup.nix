{ config, lib, pkgs, modulesPath, ... }:

{
  swapDevices = [{
    device = "/swapfile";
    size = 8 * 1024; # 8GB
  }];
}
