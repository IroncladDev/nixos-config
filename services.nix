{ config, lib, pkgs, ... }:

{
  services = {
    xserver.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    greetd = {
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
  };
}
