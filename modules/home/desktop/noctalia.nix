{ lib, config, osConfig, ... }:
let
  wallpaper = "${config.home.homeDirectory}/Pictures/Wallpapers/wall1.jpg";
in
lib.mkIf osConfig.settings.desktop.enable {
  programs.noctalia = {
    enable = true;
    systemd.enable = true;

    settings = {
      theme = {
        mode = "dark";
        source = "custom";
        custom_palette = "Nocturne";
        builtin = "Noctalia";
        community_palette = "ADW";
        wallpaper_scheme = "m3-content";
        templates.builtin_ids = [ "gtk3" "gtk4" "kcolorscheme" "qt" ];
      };

      bar.default = {
        background_opacity = 0.48;
        margin_ends = 0;
        radius_top_left = 0;
        radius_top_right = 0;
        start = [ "launcher" "workspaces" ];
        end = [ "media" "tray" "notifications" "clipboard" "session" ];
      };

      dock = {
        enabled = true;
        icon_size = 36;
        smart_auto_hide = true;
        background_opacity = 0.48;
      };

      notification = {
        background_opacity = 0.48;
        border = false;
      };

      control_center = {
        width = 800;
        hidden_tabs = [ "media" "monitor" "power" "weather" "screen-time" ];
        shortcuts = [
          { type = "wifi"; }
          { type = "bluetooth"; }
          { type = "caffeine"; }
        ];
      };

      shell = {
        lang = "en";
        font_family = "sans-serif";
        launcher = {
          app_grid = true;
          categories = false;
          compact = true;
          providers.windows.prefix = "";
        };
        panel.launcher_placement = "attached";
      };

      desktop_widgets = {
        schema_version = 2;
        widget_order = [ ];
        widget = { };
        grid = {
          cell_size = 16;
          major_interval = 4;
          visible = true;
        };
      };

      lockscreen_widgets = {
        enabled = false;
        schema_version = 2;
        widget_order = [ "lockscreen-login-box@HDMI-A-1" "lockscreen-login-box@DP-2" ];
        grid = {
          cell_size = 16;
          major_interval = 4;
          visible = true;
        };
        widget = {
          "lockscreen-login-box@DP-2" = {
            type = "login_box";
            output = "DP-2";
            box_width = 810.0;
            box_height = 229.0;
            cx = 1720.0;
            cy = 1241.5;
            rotation = 0.0;
            settings = {
              background_color = "surface_variant";
              background_opacity = 0.88;
              background_radius = 12.0;
              center_password_text = false;
              input_opacity = 1.0;
              input_radius = 6.0;
              layout = "regular";
              show_caps_lock = true;
              show_keyboard_layout = true;
              show_login_button = true;
              show_media = true;
              show_session_buttons = true;
              show_weather = true;
            };
          };

          "lockscreen-login-box@HDMI-A-1" = {
            type = "login_box";
            output = "HDMI-A-1";
            box_width = 810.0;
            box_height = 229.0;
            cx = 960.0;
            cy = 881.5;
            rotation = 0.0;
            settings = {
              background_color = "surface_variant";
              background_opacity = 0.88;
              background_radius = 12.0;
              center_password_text = false;
              input_opacity = 1.0;
              input_radius = 6.0;
              layout = "regular";
              show_caps_lock = true;
              show_keyboard_layout = true;
              show_login_button = true;
              show_media = true;
              show_session_buttons = true;
              show_weather = true;
            };
          };
        };
      };

      wallpaper = {
        default.path = wallpaper;
        monitors."DP-2".path = wallpaper;
        monitors."HDMI-A-1".path = wallpaper;
      };

      widget.media.max_length = 228;
    };
  };
}
