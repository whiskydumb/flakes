let
  palette = import ../appearance/palette.nix;
  hex = name: "#${palette.${name}}";
in
{
  imports = [ ./menu.nix ];
  programs.vicinae = {
    enable = true;
    systemd.enable = true;
    settings = {
      font.normal = {
        family = "Geologica";
        size = 11;
      };
      theme = {
        dark.name = "whisky-dark";
        light.name = "whisky-dark";
      };
      launcher_window = {
        opacity = 1.0;
        material = "none";
        rounding = 12;
      };
    };
    themes.whisky-dark = {
      meta = {
        name = "Whisky Dark";
        description = "Nocturne neutrals with Bone and Oxblood accents";
        variant = "dark";
        inherits = "vicinae-dark";
      };
      colors = {
        core = {
          background = hex "background";
          secondary_background = hex "surface";
          foreground = hex "foreground";
          border = hex "surface";
          accent = hex "accent";
          accent_foreground = hex "background";
        };
        text = {
          default = hex "foreground";
          muted = hex "muted";
          placeholder = hex "muted";
          danger = hex "error";
          success = hex "success";
          selection = {
            background = hex "blood";
            foreground = hex "onBlood";
          };
          links.default = hex "accent";
        };
        input = {
          border = hex "surface";
          border_focus = hex "accent";
          border_error = hex "error";
        };
        button.primary = {
          background = hex "blood";
          foreground = hex "onBlood";
          hover.background = hex "blood";
          focus.outline = hex "accent";
        };
        list.item.selection = {
          background = hex "blood";
          foreground = hex "onBlood";
          secondary_background = hex "surface";
          secondary_foreground = hex "muted";
        };
        loading.bar = hex "accent";
        accents = {
          red = hex "error";
          green = hex "success";
          yellow = hex "warning";
          blue = hex "info";
        };
      };
    };
  };
}
