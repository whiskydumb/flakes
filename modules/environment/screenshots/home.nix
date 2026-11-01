{
  config,
  lib,
  pkgs,
  ...
}:
let
  palette = import ../appearance/palette.nix;
  screenshot = pkgs.writeShellApplication {
    name = "screenshot";
    runtimeInputs = [
      pkgs.grim
      pkgs.slurp
      config.programs.satty.package
      pkgs.coreutils
      pkgs.util-linux
      pkgs.libnotify
      pkgs.xdg-user-dirs
    ];
    text = builtins.readFile ./screenshot.sh;
  };
in
{
  home.packages = [ screenshot ];

  programs.satty = {
    enable = true;
    settings = {
      general = {
        fullscreen = true;
        early-exit = true;
        initial-tool = "arrow";
        copy-command = "${pkgs.wl-clipboard}/bin/wl-copy --type image/png";
        save-after-copy = false;
        actions-on-enter = [ "save-to-clipboard" ];
        actions-on-escape = [ "exit" ];
      };
      font.family = "Geologica";
      color-palette.palette = map (name: "#${palette.${name}}") [
        "accent"
        "foreground"
        "success"
        "warning"
        "info"
      ];
    };
  };

  wayland.windowManager.hyprland.extraConfig = lib.mkAfter ''
    hl.bind("SUPER + SHIFT + S", hl.dsp.exec_cmd("uwsm app -- screenshot"))
    hl.bind("Print", hl.dsp.exec_cmd("uwsm app -- screenshot"))
  '';
}
