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
  imports = [];

  nixpkgs = {
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
    overlays = [
      inputs.nur.overlay
    ];
  };

  home = {
    username = "jari";
    homeDirectory = "/home/jari";

    shellAliases = {
      gs = "git status";
      gA = "git add -A";
      gc = "git commit -v --no-verify";
      gP = "git pull";

      k = "kubectl";
      pk = "kubectl --context 03926-ivido";
      h = "helm";
      ph = "helm --kube-context 03926-ivido";

      v = "nvim";
      sudo = "sudo ";
      tempy = "cd $(mktemp -d)";
    };

    packages = with pkgs; [
      dmenu
      tmux-sessionizer

      (st.overrideAttrs {
        src = builtins.fetchTarball {
          url = "https://github.com/jarimayenburg/st/archive/master.tar.gz";
          sha256 = "sha256:1hjkdsh68kdi1clqh6wy0g04hwwfn8j1g259p1n7af4281d0y7gl";
        };
      })
    ];
  };

  xsession.enable = true;

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

    initExtraFirst = ''
    # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
    # Initialization code that may require console input (password prompts, [y/n]
    # confirmations, etc.) must go above this block; everything else may go below.
    if [[ -r "''${XDG_CACHE_HOME:-\$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
      source "''${XDG_CACHE_HOME:-\$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
    fi
    '';

    initExtra = ''
    bindkey -v
    '';

    history = {
      size = 10000;
      save = 10000;
      ignoreAllDups = true;
      ignorePatterns = [ "ls" "ps" "history" ];
    };

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        file = "p10k.zsh";
        src = lib.cleanSource ./config;
      }
    ];

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "taskwarrior" "bazel" "helm" ];
    };
  };

  # Configuration for fzf
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  # Configuration for neovim
  xdg.configFile.nvim = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/config/nvim";
  };
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
  };

  # Configuration for tmux
  programs.tmux = {
    enable = true;
    terminal = "screen-256color";
    baseIndex = 1;
    prefix = "C-a";
    reverseSplit = true;
    mouse = true;
    aggressiveResize = true;
    clock24 = true;
    escapeTime = 0;
    historyLimit = 50000;
    extraConfig = builtins.readFile (lib.cleanSource ./config/tmux.conf);

    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.gruvbox;
        extraConfig = ''
          set -g @tmux-gruvbox 'dark'
        '';
      }
      {
        plugin = tmuxPlugins.sensible;
      }
    ];
  };

  # Configuration for tmux-sessionizer
  xdg.configFile.tms = {
    source = ./config/tms;
  };

  # Configuration for firefox
  programs.firefox = {
    enable = true;
    profiles = {
      ${config.home.username} = {
        isDefault = true;
        name = "${config.home.username}";
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          bitwarden
          ublock-origin
        ];
      };
    };
  };

  # Configuration for Chromium
  programs.chromium.enable = true;

  # Configuration for sxhkd
  services.sxhkd = {
    enable = true;
    keybindings = {
      # Brightness control
      "XF86MonBrightness{Down,Up}" = "xbacklight {-dec,-inc} 10";

      # Volume control
      "XF86AudioMute" = "amixer -q sset Master toggle && kill -s SIGUSR1 $(pgrep statusbard)";

      "XF86Audio{Lower,Raise}Volume" = "amixer -q sset Master 5%{-,+} && kill -s SIGUSR1 $(pgrep statusbard)";

      # Lock the screen
      "super + shift + l" = "betterlockscreen -l";

      # Change the wallpaper
      "super + F7" = "pkill randwald; randwald -l &";

      # Save the current wallpaper to the wallpaper folder
      "super + shift + F7" = "savewal";

      # Delete the current wallpaper from the wallpaper folder
      "super + alt + shift + F7" = "savewal -d";

      # Set a random local wallpaper permanently
      "super + alt + F7" = "pkill randwald; randwal -l";

      # Application shortcuts
      "super + {w, q, s, c, g}" = "{firefox, qutebrowser, slack, slack, ghopen}";

      # Tmux sessionizer
      "super + o" = "st tms";

      # Incognito browser window
      "super + shift + w" = "firefox --private-window";

      # Screenshots
      "Print" = "maim -s | xclip -selection clipboard -t image/png";
    };
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.05";
}
