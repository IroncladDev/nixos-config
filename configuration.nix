{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./apple-silicon-support
      ./system.nix
    ];

  hardware.asahi.peripheralFirmwareDirectory = ./firmware;

  boot.kernelModules = [ "uinput" ];

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ 
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
    ];
  };

  users.groups.uinput = {};
  users.users.ironcladdev = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "input" "audio" "networkmanager" "uinput" ];
    packages = with pkgs; [
      tree
    ];
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session.command = "tuigreet --cmd Hyprland";
      terminal = {
        vt = 1;
        reset = true;
        clear = true;
      };
    };
  };

  # services.udev.extraRules = ''
  #   KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
  # '';

  # For Asahi NixOS specifically
  services.udev.packages = [ pkgs.udev ];
  services.udev.extraRules = ''
    SUBSYSTEM=="input", KERNEL=="uinput", MODE="0660", GROUP="input"
    SUBSYSTEM=="misc", KERNEL=="uinput", MODE="0660", GROUP="input"
  '';

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  programs.starship.enable = true;

  environment.systemPackages = with pkgs; [
    kitty
    neovim
    git
    yazi
    (waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    }))
    dunst
    libnotify
    swww
    rofi
    brave
    magic-wormhole
    tuigreet
    gh
    kanata-with-cmd
  ];
}
