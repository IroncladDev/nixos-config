{ config, pkgs, lib, ... }:

{
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelParams = [
      "quiet"
      "logLevel=0"
    ];
    consoleLogLevel = 0;
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  time.timeZone = "America/Chicago";

  security.rtkit.enable = true;

  system = {
    copySystemConfiguration = true;
    # This option defines the first version of NixOS you have installed on this particular machine
    # DO NOT CHANGE THIS VALUE
    stateVersion = "25.11";
  };
}
