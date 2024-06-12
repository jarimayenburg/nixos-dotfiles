{ inputs, pkgs, ... }:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  config = {
    # Disable the greeter and automatically login the user
    services.displayManager = {
      defaultSession = "none+dwm";
      autoLogin = {
        enable = true;
        user = "jari";
      };
    };

    # Set up dwm as the window manager
    services.xserver = {
      enable = true;

      # Configure keymap in X11
      xkb = {
        layout = "us";
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

    # Upower is needed for the DWM statusbar battery info
    services.upower = {
      enable = true;
    };

    # dwm-status runs as a custom systemd service
    systemd.user.services.dwm-status = {
      enable = true;
      description = "DWM status service";

      partOf = [ "graphical-session.target" ];
      wants = ["network.target"];
      after = ["network.target"];

      wantedBy = [ "graphical-session.target" ];

      serviceConfig = {
        ExecStart = "${pkgs.dwm-status}/bin/dwm-status ${../../config/dwm-status.toml}";
        Restart = "always";
      };
    };
  };
}
