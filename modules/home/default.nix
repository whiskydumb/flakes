{ osConfig, ... }:
let
  user = osConfig.settings.username;
in
{
  imports = [
    ./shell
    ./desktop
    ./theme

    ./git.nix
    ./dev.nix
    ./apps.nix
    ./xdg.nix
    ./neovim.nix
    ./zed.nix
  ];

  _module.args.palette = import ../../lib/palette.nix;

  home.username = user;
  home.homeDirectory = "/home/${user}";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;
}
