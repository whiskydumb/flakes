{ ... }:
{
  programs.zed-editor = {
    enable = true;

    extensions = [
      "nix"
      "toml"
    ];

    userSettings = {
      theme = "Nocturne Dark";

      buffer_font_family = "IosevkaTerm Nerd Font Mono";
      buffer_font_size = 14;
      ui_font_family = "Inter";

      vim_mode = false;
      format_on_save = "on";

      telemetry = {
        metrics = false;
        diagnostics = false;
      };
    };
  };
}
