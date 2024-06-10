{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    alsa-utils
  ];

  services.dwm-status = {
    enable = true;
    order = ["network" "backlight" "audio" "battery" "time"];
    extraConfig = ''
      separator = "    "

      [audio]
      mute = "ﱝ"
      template = "{ICO} {VOL}%"
      icons = ["奄", "奔", "墳"]
      control = "Master"

      [backlight]
      device = "intel_backlight"
      template = "{ICO} {BL}%"
      icons = ["", "", ""]

      [battery]
      enable_notifier = true
      charging = ""
      discharging = ""
      no_battery = ""
      notifier_critical = 10
      notifier_levels = [2, 5, 10, 15, 20]
      separator = " · "
      icons = ["", "", "", "", "", "", "", "", "", "", ""]

      [cpu_load]
      template = "{CL1} {CL5} {CL15}"
      update_interval = 20

      [network]
      no_value = "NA"
      template = "{ESSID} ({IPv4})"

      [time]
      format = "%Y-%m-%d %H:%M:%S"
      update_seconds = true
      '';
  };

  services.upower = {
    enable = true;
  };
}
