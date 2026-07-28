{ lib, pkgs, palette, ... }:
let
  c = palette.dark;

  ansi = with c.ansi; [
    black
    red
    green
    yellow
    blue
    magenta
    cyan
    white
    brightBlack
    brightRed
    brightGreen
    brightYellow
    brightBlue
    brightMagenta
    brightCyan
    brightWhite
  ];
in
{
  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;

    settings = {
      command = "${pkgs.fish}/bin/fish";

      background = c.terminalBg;
      foreground = c.terminalFg;
      cursor-color = c.accent;
      selection-background = c.selection;
      selection-foreground = c.terminalFg;
      palette = lib.imap0 (i: color: "${toString i}=#${color}") ansi;

      font-family = "IosevkaTerm Nerd Font Mono";
      font-size = 12;
      background-opacity = 0.95;
      cursor-style = "bar";
      window-padding-x = 8;
      window-padding-y = 8;
      window-save-state = "always";
      confirm-close-surface = false;
    };
  };
}
