{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    clang
    clang-tools
    cmake
    dive
    docker
    fd
    file
    gcc
    gcc11
    gdb
    glibc_multi
    gnumake
    gnupg
    go
    insomnia
    jdk11
    jdk17
    jdk8
    jdt-language-server
    kubectl
    libxkbcommon
    lldb
    lua
    nodejs
    php
    pinentry-curses
    pkg-config
    ripgrep
    rustup
    slack
    valgrind
    vim
    vscode-fhs
    wasm-pack
    xclip
    xorg.libX11.dev
    xorg.libXft
    xorg.libXinerama

    (google-cloud-sdk.withExtraComponents( with google-cloud-sdk.components; [
      gke-gcloud-auth-plugin
    ]))
  ];

  # Enable Docker
  virtualisation.docker.enable = true;

  # Enable GPG for e.g. signing commits
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-curses;
  };
}
