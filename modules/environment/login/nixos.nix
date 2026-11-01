{ lib, pkgs, ... }:
let
  palette = import ../appearance/palette.nix;
  theme = "container=black;border=bright-black;text=white;time=cyan;title=bright-red;greet=white;prompt=bright-red;input=white;action=cyan;button=bright-red";
in
{
  console.colors = [
    palette.background
    palette.blood
    "00aa00"
    "aa5500"
    "0000aa"
    "aa00aa"
    palette.muted
    palette.foreground
    palette.surface
    palette.accent
    "55ff55"
    "ffff55"
    "5555ff"
    "ff55ff"
    "55ffff"
    palette.onBlood
  ];
  services.greetd = {
    enable = true;
    settings.default_session = {
      user = "greeter";
      command = "${lib.getExe pkgs.tuigreet} --time --remember --theme ${lib.escapeShellArg theme} --cmd '${lib.getExe pkgs.uwsm} start -eD Hyprland hyprland.desktop'";
    };
  };
}
