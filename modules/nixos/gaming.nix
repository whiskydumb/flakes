{ lib, config, pkgs, ... }:
{
  config = lib.mkIf config.settings.gaming.enable {
    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;

      remotePlay.openFirewall = false;
      dedicatedServer.openFirewall = false;

      extraCompatPackages = [ pkgs.proton-ge-bin ];
      protontricks.enable = true;
    };

    programs.gamescope = {
      enable = true;
      capSysNice = true;
    };

    programs.gamemode.enable = true;

    environment.systemPackages = with pkgs; [
      mangohud
      umu-launcher
      prismlauncher
    ];

    security.pam.loginLimits = [
      {
        domain = "@users";
        item = "nofile";
        type = "hard";
        value = "524288";
      }
    ];
  };
}
