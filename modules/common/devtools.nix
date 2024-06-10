{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    clang
    clang-tools
    cmake
    docker
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
    libxkbcommon
    lldb
    lua
    nodejs
    php
    pkg-config
    rustup
    valgrind
    vim
    vscode-fhs
    xorg.libX11.dev
    xorg.libXft
    xorg.libXinerama
    wasm-pack

    slack
  ];
}
