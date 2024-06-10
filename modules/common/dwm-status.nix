{ inputs, pkgs, lib, ... }:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  config = {
    services.upower = {
      enable = true;
    };

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
