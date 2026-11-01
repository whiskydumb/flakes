{
  imports = [
    ../../modules/environment/hyprland/home.nix
    ../../modules/environment/lock/home.nix
    ../../modules/environment/shell/home.nix
    ../../modules/environment/appearance/home.nix
    ../../modules/environment/launcher/home.nix
    ../../modules/environment/terminal/home.nix
    ../../modules/environment/screenshots/home.nix
    ../../modules/audio/home.nix
    ../../modules/files/home.nix
  ];

  home = {
    username = "whisky";
    homeDirectory = "/home/whisky";
    stateVersion = "26.05";
  };

  programs.home-manager.enable = true;
}
