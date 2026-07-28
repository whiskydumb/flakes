{ config, ... }:
{
  imports = [
    ./options.nix
    ./boot.nix
    ./nix.nix
    ./networking.nix
    ./locale.nix
    ./hardware.nix
    ./storage.nix
    ./fonts.nix
    ./users.nix
    ./desktop.nix
    ./graphics.nix
    ./gaming.nix
    ./virtualisation.nix
    ./printing.nix
    ./browser.nix
    ./secrets.nix
  ];

  home-manager.users.${config.settings.username} = import ../home;
}
