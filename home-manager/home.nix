# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
  ];

  nixpkgs = {
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "jari";
    homeDirectory = "/home/jari";

    packages = with pkgs; [
      firefox
      fzf
      dmenu

      (st.overrideAttrs {
        src = builtins.fetchTarball {
          url = "https://github.com/jarimayenburg/st/archive/master.tar.gz";
          sha256 = "sha256:1hjkdsh68kdi1clqh6wy0g04hwwfn8j1g259p1n7af4281d0y7gl";
        };
      })
    ];
  };

  programs.home-manager.enable = true;

  # Configuration for git
  programs.git = {
    enable = true;
    userName = "Jari Maijenburg";
    userEmail = "jari.maijenburg@formelio.nl";
    extraConfig = {
      pull.rebase = true;
      init.defaultBranch = "master";
      core.autocrlf = "input";
    };
  };

  # Configuration for zsh
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "taskwarrior" "zsh-completions" "bazel" "helm" ];
      theme = "powerlevel10k/powerlevel10k";
    };
  };

  # Configuration for neovim
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.05";
}
