let
  p = import ../appearance/palette.nix;
in
{
  programs.ghostty = {
    enable = true;
    settings = {
      font-family = "IosevkaTerm Nerd Font Mono";
      font-size = 14;
      background = p.background;
      foreground = p.foreground;
      background-opacity = 1;
      cursor-color = p.accent;
      cursor-text = p.background;
      selection-background = p.blood;
      selection-foreground = p.onBlood;
      window-padding-x = 20;
      window-padding-y = 20;
      palette = [
        "0=#1a1a1a"
        "1=#e06060"
        "2=#70d4a0"
        "3=#e8c840"
        "4=#7e9fdc"
        "5=#b49bd4"
        "6=#70c8d4"
        "7=#c0c0c0"
        "8=#5a5a5a"
        "9=#f0a0a0"
        "10=#90e4b8"
        "11=#f0d870"
        "12=#a0b8e0"
        "13=#c8b0e0"
        "14=#98dce6"
        "15=#ffffff"
      ];
    };
  };
}
