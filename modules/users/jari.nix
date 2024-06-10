{ inputs, outputs, pkgs, ... }:
{
  # Home manager setup
  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    users = {
      jari = import ../../home.nix;
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jari = {
    isNormalUser = true;
    extraGroups = [ "jari" "wheel" "docker" "networkmanager" ];
    shell = pkgs.zsh;
  };
}
