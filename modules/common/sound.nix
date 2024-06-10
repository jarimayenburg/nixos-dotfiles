{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    alsa-lib
    pavucontrol
  ];

  # Enable sound.
  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}
