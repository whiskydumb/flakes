{ pkgs, inputs, ... }:
{
  imports = [
    ./zed
    ./neovim
    ./spotify.nix
    ./unreal
  ];
  home.packages = [
    inputs.nixpkgs-unstable.legacyPackages.${pkgs.stdenv.hostPlatform.system}.godot
    inputs.helium.packages.${pkgs.stdenv.hostPlatform.system}.default
    pkgs.vesktop
    pkgs.prismlauncher
    pkgs.nodejs
    pkgs.ffmpeg
  ];

  programs.mpv.enable = true;
  programs.obs-studio.enable = true;
}
