{ inputs, pkgs, ... }:
{
  imports = [
    ./devtools.nix
    ./displays.nix
    ./dwm.nix
    ./fonts.nix
    ./generic.nix
    ./sound.nix
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable experimental features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Set the time zone.
  time.timeZone = "Europe/Amsterdam";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Set TTY font size
  console = {
    earlySetup = true;
    font = "${pkgs.terminus_font}/share/consolefonts/ter-i32n.psf.gz";
    useXkbConfig = true; # use xkb.options in tty.
    packages = with pkgs; [ terminus_font ];
  };

  # Enable networkmanager
  networking.networkmanager.enable = true;

  # Enable CUPS for printing
  services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Enable ZSH and make it the default
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Enable the picom compositor
  services.picom.enable = true;

  # Enable bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;
}
