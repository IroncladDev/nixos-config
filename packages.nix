{ config, lib, pkgs, ... }:

{
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
  ];
}
