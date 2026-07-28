{ config, ... }:
{
  networking.hostName = config.settings.hostName;
  networking.networkmanager.enable = true;
  networking.firewall.enable = true;

  programs.throne = {
    enable = true;
    tunMode.enable = true;
  };

  services.resolved.enable = true;
}
