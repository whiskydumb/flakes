{ pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    configType = "lua";
    systemd.enable = false;
    extraConfig = builtins.readFile ./hyprland.lua;
  };

  home.packages = [ pkgs.wl-clipboard ];
}
