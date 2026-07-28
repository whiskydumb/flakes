{ pkgs, ... }:
{
  home.packages = with pkgs; [
    vesktop
    mpv
    qview

    kdePackages.dolphin
    kdePackages.kio-extras
    kdePackages.ark

    yazi

    wl-clipboard

    pavucontrol
  ];

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      obs-vkcapture
    ];
  };
}
