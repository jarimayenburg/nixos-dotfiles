{ pkgs, ... }:
{
  imports = [
    ./fonts.nix
    ./dwm.nix
    ./sound.nix
    ./devtools.nix
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

  # Enable ZSH
  programs.zsh.enable = true;

  # Enable the picom compositor
  services.picom.enable = true;
}
