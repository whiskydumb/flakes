{
  nixpkgs.hostPlatform = "x86_64-linux";
  networking.hostName = "ci-workstation";
  boot.loader.grub.enable = false;
  fileSystems."/" = {
    device = "none";
    fsType = "tmpfs";
  };
  system.stateVersion = "26.05";
}
