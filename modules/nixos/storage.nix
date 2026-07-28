{ ... }:
{
  services.btrfs.autoScrub.enable = true;

  boot.tmp.cleanOnBoot = true;

  zramSwap.enable = true;
}
