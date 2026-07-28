{ inputs, ... }:
{
  imports = [
    inputs.disko.nixosModules.disko
    ./disko.nix
    ./hardware.nix
  ];

  settings.hostName = "mochi";
  settings.desktop.enable = true;
  settings.amd.enable = true;
  settings.gaming.enable = true;

  hardware.cpu.amd.updateMicrocode = true;

  system.stateVersion = "26.05";
}
