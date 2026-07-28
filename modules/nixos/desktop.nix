{ lib, config, pkgs, ... }:
let
  user = config.settings.username;
in
{
  config = lib.mkIf config.settings.desktop.enable {
    programs.niri.enable = true;
    programs.niri.useNautilus = false;

    environment.systemPackages = [ pkgs.xwayland-satellite ];

    security.polkit.enable = true;

    systemd.user.services.polkit-kde-authentication-agent-1 = {
      description = "polkit authentication agent";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };

    services.gvfs.enable = true;
    services.udisks2.enable = true;

    services.blueman.enable = true;

    services.greetd = {
      enable = true;
      settings = {
        initial_session = {
          command = "niri-session";
          user = user;
        };
        default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd niri-session";
          user = "greeter";
        };
      };
    };
  };
}
