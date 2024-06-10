{ pkgs, ... }:
{
  imports = [
    ./dwm-status.nix
  ];

  services.displayManager = {
    defaultSession = "none+dwm";
    autoLogin = {
      enable = true;
      user = "jari";
    };
  };

  services.xserver = {
    enable = true;

    # Configure keymap in X11
    xkb = {
      layout = "us";
      options = "eurosign:e,caps:escape";
    };

    # Setup DWM as the window manager
    windowManager = {
      dwm.enable = true;
      dwm.package = pkgs.dwm.overrideAttrs {
        src = builtins.fetchTarball {
          url = "https://github.com/jarimayenburg/dwm/archive/master.tar.gz";
          sha256 = "sha256:127dqsqz2khkd6fhysfihqmyj2s25l4d8snwvijrq9gg177cnv05";
        };
      };
    };
  };
}
