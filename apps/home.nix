{ pkgs, inputs, ... }:
{
  imports = [
    ./zed
    ./neovim
    ./spotify.nix
  ];
  home.packages = [
    inputs.helium.packages.${pkgs.stdenv.hostPlatform.system}.default
    pkgs.vesktop
    pkgs.prismlauncher
    pkgs.nodejs
    pkgs.ffmpeg
  ];

  programs.mpv.enable = true;
  programs.obs-studio.enable = true;
}
