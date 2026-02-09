{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./apple-silicon-support
      ./system.nix
      ./packages.nix
      ./services.nix
      ./programs.nix
    ];

  hardware = {
    asahi.peripheralFirmwareDirectory = ./firmware;
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ 
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
    ];
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ironcladdev = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "input" "audio" "networkmanager" ];
    packages = with pkgs; [
      tree
    ];
  };
}
