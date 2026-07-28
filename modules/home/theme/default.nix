{ lib, pkgs, palette, osConfig, ... }:
let
  json = (pkgs.formats.json { }).generate;

  zed = import ./zed.nix { inherit lib palette; };
  neovim = import ./neovim.nix { inherit lib palette; };
  noctalia = import ./noctalia.nix { inherit palette; };

  desktop = osConfig.settings.desktop.enable;
in
{
  home.file.".config/zed/themes/nocturne.json".source = json "nocturne.json" zed;
  xdg.configFile."nvim/colors/nocturne.lua".text = neovim;

  xdg.configFile."noctalia/palettes/Nocturne.json" = lib.mkIf desktop {
    source = json "Nocturne.json" noctalia;
  };

  home.pointerCursor = lib.mkIf desktop {
    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };
}
