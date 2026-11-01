{
  config,
  lib,
  pkgs,
  ...
}:
let
  palette = import ../appearance/palette.nix;
  rgb = name: "rgb(${palette.${name}})";
in
{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        hide_cursor = true;
        ignore_empty_input = true;
      };
      background = [
        {
          monitor = "";
          color = rgb "background";
        }
      ];
      label = [
        {
          monitor = "";
          text = "$TIME";
          font_size = 64;
          font_family = "Geologica";
          color = rgb "foreground";
          position = "0, 100";
          halign = "center";
          valign = "center";
        }
      ];
      input-field = [
        {
          monitor = "";
          size = "300, 52";
          position = "0, -40";
          halign = "center";
          valign = "center";
          rounding = 8;
          outline_thickness = 0;
          inner_color = rgb "surface";
          font_color = rgb "foreground";
          font_family = "Geologica";
          check_color = rgb "accent";
          fail_color = rgb "error";
          placeholder_text = "<span foreground='##${palette.muted}'>Password</span>";
          fail_text = "<span foreground='##${palette.error}'>Incorrect password</span>";
          fade_on_empty = false;
        }
      ];
    };
  };
  systemd.user.services.hyprlock = {
    Unit = {
      Description = "Lock the graphical session";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = lib.getExe config.programs.hyprlock.package;
      Restart = "on-failure";
      RestartSec = 1;
    };
  };

  services.hypridle = {
    enable = true;
    systemdTarget = "graphical-session.target";
    settings.general = {
      lock_cmd = "${pkgs.systemd}/bin/systemctl --user start hyprlock.service";
      before_sleep_cmd = "${pkgs.systemd}/bin/loginctl lock-session";
      inhibit_sleep = 3;
    };
  };
}
