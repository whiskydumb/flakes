{ lib, config, ... }:
{
  config = lib.mkIf config.settings.desktop.enable {
    programs.helium.enable = true;
  };
}
