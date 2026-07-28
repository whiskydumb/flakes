{ config, pkgs, ... }:
let
  user = config.settings.username;
in
{
  programs.fish.enable = true;

  users.mutableUsers = false;

  users.users.${user} = {
    isNormalUser = true;
    description = "whisky";
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "audio"
      "input"
      "docker"
    ];
    shell = pkgs.fish;
    hashedPasswordFile = config.sops.secrets."passwords/${user}".path;
  };
}
