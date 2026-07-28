{ palette, ... }:
let
  u = hex: builtins.fromJSON "\"\\u${hex}\"";

  capL = u "e0b6";
  capR = u "e0b4";
  gitGlyph = u "e0a0";
  nixGlyph = u "f313";
  nodeGlyph = u "e718";
  arrow = u "2771";
  ellipsis = u "2026";

  c = palette.dark;
  inherit (palette) hex;
in
{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;

    settings = {
      add_newline = true;

      format = "[ whisky ](bg:${hex c.accent} fg:black)[${capR}](${hex c.accent}) \${env_var._NIX_SHELL_INFO}$nix_shell$hostname$git_branch$git_status$nodejs\n$directory$character";

      character = {
        success_symbol = "[${arrow}](${hex c.green})";
        error_symbol = "[${arrow}](${hex c.red})";
      };

      hostname = {
        style = "bg:${hex c.cyan} fg:black";
        format = "[${capL}](${hex c.cyan})[$hostname]($style)[${capR}](${hex c.cyan}) ";
        ssh_only = true;
      };

      directory = {
        style = hex c.accent;
        format = "[$path ]($style)";
        truncation_length = 3;
        truncation_symbol = "${ellipsis}/";
      };

      git_branch = {
        symbol = gitGlyph;
        style = "bg:${hex c.orange} fg:black";
        format = "[${capL}](fg:${hex c.orange})[$symbol $branch ]($style)";
      };

      git_status = {
        style = "bg:${hex c.orange} fg:black";
        format = "[$all_status$ahead_behind ]($style)[${capR}](fg:${hex c.orange}) ";
      };

      nix_shell = {
        style = "bg:${hex c.accent} fg:black";
        format = "[${capL}](${hex c.accent})[${nixGlyph} $name]($style)[${capR}](${hex c.accent}) ";
      };

      env_var._NIX_SHELL_INFO = {
        style = "bg:${hex c.accent} fg:black";
        format = "[${capL}](${hex c.accent})[${nixGlyph} $env_value]($style)[${capR}](${hex c.accent}) ";
      };

      nodejs = {
        style = "bg:${hex c.green} fg:black";
        version_format = "$major.$minor";
        format = "[${capL}](${hex c.green})[${nodeGlyph} $version]($style)[${capR}](${hex c.green}) ";
      };
    };
  };
}
