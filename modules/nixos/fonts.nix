{ pkgs, ... }:
{
  fonts = {
    enableDefaultPackages = true;

    packages = with pkgs; [
      inter
      nerd-fonts.iosevka-term
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
    ];

    fontconfig.defaultFonts = {
      sansSerif = [ "Inter" "Noto Sans" ];
      monospace = [ "IosevkaTerm Nerd Font Mono" ];
      serif = [ "Noto Serif" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };
}
