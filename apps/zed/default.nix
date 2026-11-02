{ lib, pkgs, ... }:
{
  programs.zed-editor = {
    enable = true;
    extensions = builtins.fromJSON (builtins.readFile ./extensions.json);
    userSettings = lib.recursiveUpdate (builtins.fromJSON (builtins.readFile ./settings.json)) {
      terminal.shell.program = lib.getExe pkgs.fish;
    };
  };

  xdg.configFile."zed/themes/nocturne-dark.json".source = ./nocturne-dark.json;
}
