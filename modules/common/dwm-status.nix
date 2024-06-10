{ pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
    alsa-utils
  ];

  services.dwm-status = {
    enable = true;
    order = ["network" "backlight" "audio" "battery" "time"];
    extraConfig = builtins.readFile (lib.cleanSource ../../config/dwm-status.toml);
  };

  services.upower = {
    enable = true;
  };
}
