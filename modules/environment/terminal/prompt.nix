let
  p = import ../appearance/palette.nix;
in
{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      add_newline = true;
      format = "$username$hostname$directory$git_branch$git_status$nix_shell$all$line_break$character";
      palette = "whisky";
      palettes.whisky = {
        black = "#${p.background}";
        white = "#${p.foreground}";
        red = "#${p.muted}";
        green = "#${p.muted}";
        yellow = "#${p.muted}";
        blue = "#${p.muted}";
        purple = "#${p.muted}";
        cyan = "#${p.muted}";
        accent = "#${p.accent}";
        muted = "#${p.muted}";
        success = "#${p.success}";
        error = "#${p.error}";
      };
      username = {
        show_always = false;
        style_user = "muted";
        style_root = "bold error";
        format = "[$user]($style) ";
      };
      hostname = {
        ssh_only = true;
        style = "muted";
        format = "[@$hostname]($style) ";
      };
      directory = {
        style = "white";
        truncation_length = 3;
        truncate_to_repo = false;
        format = "[$path]($style)[$read_only]($read_only_style) ";
        read_only_style = "error";
      };
      git_branch = {
        format = "[$branch]($style) ";
        style = "accent";
      };
      git_status.style = "accent";
      nix_shell = {
        format = "[nix(:$name)]($style) ";
        style = "muted";
      };
      cmd_duration = {
        min_time = 3000;
        format = "[$duration]($style) ";
        style = "muted";
      };
      character = {
        success_symbol = "[❯](success)";
        error_symbol = "[❯](error)";
      };
      c = {
        disabled = false;
        style = "muted";
      };
      cpp = {
        disabled = false;
        style = "muted";
      };
      package.disabled = true;
      battery.disabled = true;
    };
  };
}
