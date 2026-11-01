{ pkgs, ... }:
{
  home.packages = [
    (pkgs.google-fonts.override { fonts = [ "Geologica" ]; })
    pkgs.nerd-fonts.iosevka
    pkgs.nerd-fonts.iosevka-term
    pkgs.noto-fonts
    pkgs.noto-fonts-color-emoji
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      sansSerif = [
        "Geologica"
        "Noto Sans"
      ];
      serif = [ "Noto Serif" ];
      monospace = [
        "Iosevka Nerd Font Mono"
        "Noto Sans Mono"
      ];
      emoji = [ "Noto Color Emoji" ];
    };
  };

  gtk.font = {
    name = "Geologica";
    size = 11;
  };

  home.pointerCursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

}
