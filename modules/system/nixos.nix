{ pkgs, ... }:
{
  nix.package = pkgs.lixPackageSets.stable.lix;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  environment.systemPackages = [
    pkgs.git
    pkgs.just
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "before-home-manager";
  };
}
