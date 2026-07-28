{ lib, ... }:
{
  options.settings = {
    username = lib.mkOption {
      type = lib.types.str;
      default = "whisky";
      description = "primary user login name";
    };

    hostName = lib.mkOption {
      type = lib.types.str;
      description = "system hostname";
    };

    desktop.enable = lib.mkEnableOption "graphical session";
    gaming.enable = lib.mkEnableOption "gaming";
    amd.enable = lib.mkEnableOption "AMD GPU";
  };
}
