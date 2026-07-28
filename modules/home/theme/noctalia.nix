{ palette }:
let
  inherit (palette) hex;

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
  };
in
{
  dark = roles palette.dark;
  light = roles palette.light;
}
