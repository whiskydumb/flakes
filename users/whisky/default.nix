{ pkgs, ... }:
{
  programs.fish.enable = true;
  users.users.whisky = {
    isNormalUser = true;
    description = "whisky";
    extraGroups = [ "wheel" ];
    shell = pkgs.fish;
  };

  home-manager.users.whisky = import ./home.nix;
}
