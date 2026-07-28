{ palette }:
let
  inherit (palette) hex;

  roles = c: {
    primary = hex c.accent;
    on_primary = hex c.bg;
    secondary = hex c.cyan;
    on_secondary = hex c.bg;
    tertiary = hex c.magenta;
    on_tertiary = hex c.bg;
    error = hex c.red;
    on_error = hex c.bg;

    surface = hex c.bg;
    surface_variant = hex c.surface;
    on_surface = hex c.fg;
    on_surface_variant = hex c.muted;

    hover = hex c.elementHover;
    on_hover = hex c.fg;

    outline = hex c.border;
    shadow = "#000000";
  };
in
{
  dark = roles palette.dark;
  light = roles palette.light;
}
