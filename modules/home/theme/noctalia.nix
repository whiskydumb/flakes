{ palette }:
let
  inherit (palette) hex;

  ansi = a: {
    black = hex a.black;
    red = hex a.red;
    green = hex a.green;
    yellow = hex a.yellow;
    blue = hex a.blue;
    magenta = hex a.magenta;
    cyan = hex a.cyan;
    white = hex a.white;
  };

  bright = a: {
    black = hex a.brightBlack;
    red = hex a.brightRed;
    green = hex a.brightGreen;
    yellow = hex a.brightYellow;
    blue = hex a.brightBlue;
    magenta = hex a.brightMagenta;
    cyan = hex a.brightCyan;
    white = hex a.brightWhite;
  };

  roles = c: {
    mPrimary = hex c.accent;
    mOnPrimary = hex c.bg;
    mSecondary = hex c.cyan;
    mOnSecondary = hex c.bg;
    mTertiary = hex c.magenta;
    mOnTertiary = hex c.bg;
    mError = hex c.red;
    mOnError = hex c.bg;

    mSurface = hex c.bg;
    mSurfaceVariant = hex c.surface;
    mOnSurface = hex c.fg;
    mOnSurfaceVariant = hex c.muted;

    mHover = hex c.elementHover;
    mOnHover = hex c.fg;

    mOutline = hex c.border;
    mShadow = "#000000";

    terminal = {
      normal = ansi c.ansi;
      bright = bright c.ansi;
      foreground = hex c.terminalFg;
      background = hex c.terminalBg;
      cursor = hex c.accent;
      cursorText = hex c.bg;
      selectionFg = hex c.terminalFgBright;
      selectionBg = hex c.selection;
    };
  };
in
{
  dark = roles palette.dark;
  light = roles palette.light;
}
