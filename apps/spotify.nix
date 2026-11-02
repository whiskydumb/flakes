{ pkgs, inputs, ... }:
let
  p = import ../modules/environment/appearance/palette.nix;
  spice = inputs.spicetify.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
{
  programs.spicetify = {
    enable = true;
    theme = spice.themes.text;
    customColorScheme = {
      accent = p.accent;
      accent-active = p.accent;
      accent-inactive = p.surface;
      banner = p.accent;
      border-active = p.accent;
      border-inactive = "252525";
      header = p.muted;
      highlight = p.blood;
      main = p.background;
      notification = p.info;
      notification-error = p.error;
      subtext = p.muted;
      text = p.foreground;
    };
    enabledExtensions = with spice.extensions; [
      shuffle
      copyToClipboard
      hidePodcasts
      adblock
      volumePercentage
      aiBandBlocker
    ];
  };
}
