{ lib, osConfig, ... }:
lib.mkIf osConfig.settings.desktop.enable {
  programs.noctalia = {
    enable = true;
    systemd.enable = true;

    settings.theme = {
      source = "custom";
      custom_palette = "Nocturne";
    };
  };
}
