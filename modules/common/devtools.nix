{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    clang
    clang-tools
    cmake
    docker
    file
    gcc
    gcc11
    gdb
    glibc_multi
    gnumake
    go
    jdk11
    jdk17
    jdk8
    jdt-language-server
    kubectl
    insomnia
    libxkbcommon
    lldb
    lua
    nodejs
    php
    pinentry-curses
    gnupg
    pkg-config
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
  ];

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-curses;
  };
}
