{ pkgs, ... }:
{
  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      liberation_ttf
      (nerdfonts.override { fonts = [ "Hack" "Ubuntu" ]; })
    ];

    fontconfig = {
      defaultFonts = {
        serif = [ "Tinos" ];
        sansSerif = [ "Arimo" ];
        monospace = [ "Hack Nerd Font Mono" ];
      };
    };
  };
}
