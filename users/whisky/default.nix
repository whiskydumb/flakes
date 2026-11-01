{
  users.users.whisky = {
    isNormalUser = true;
    description = "whisky";
    extraGroups = [ "wheel" ];
  };

  home-manager.users.whisky = import ./home.nix;
}
