{
  imports = [
    ./base.nix
    ../modules/networking/networkmanager.nix
    ../modules/environment/hyprland/nixos.nix
    ../modules/environment/login/nixos.nix
    ../modules/environment/lock/nixos.nix
    ../modules/environment/shell/nixos.nix
    ../modules/audio/nixos.nix
    ../modules/files/nixos.nix
    ../modules/security/polkit.nix
  ];

  nixpkgs.config.allowUnfree = true;
}
