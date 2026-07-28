{ lib, palette, osConfig, ... }:
let
  c = palette.dark;
  inherit (palette) hex;
in
lib.mkIf osConfig.settings.desktop.enable {
  xdg.configFile."niri/config.kdl".text = ''

    input {
        keyboard {
            xkb {
                layout "us,ru"
                options "grp:alt_shift_toggle"
            }
            repeat-delay 400
            repeat-rate 40
        }

        mouse {
            accel-profile "flat"
        }

        focus-follows-mouse max-scroll-amount="0%"
    }

    output "DP-1" {
        position x=0 y=0
    }

    output "DP-2" {
        position x=-1920 y=180
    }

    layout {
        gaps 8
        center-focused-column "never"

        preset-column-widths {
            proportion 0.33333
            proportion 0.5
            proportion 0.66667
        }

        default-column-width { proportion 0.5; }

        focus-ring {
            width 2
            active-color "${hex c.accent}"
            inactive-color "${hex c.border}"
        }

        border {
            off
        }
    }

    environment {
        NIXOS_OZONE_WL "1"
        ELECTRON_OZONE_PLATFORM_HINT "auto"

        QT_QPA_PLATFORM "wayland;xcb"
    }

    prefer-no-csd

    screenshot-path "~/Pictures/Screenshots/screenshot-%Y-%m-%d-%H-%M-%S.png"

    spawn-at-startup "throne"
    spawn-at-startup "vesktop"

    binds {
        Mod+Shift+Slash { show-hotkey-overlay; }

        Mod+T hotkey-overlay-title="terminal" { spawn "ghostty"; }
        Mod+E hotkey-overlay-title="files" { spawn "dolphin"; }

        Mod+D hotkey-overlay-title="launcher" { spawn "noctalia" "msg" "launcher"; }
        Mod+V hotkey-overlay-title="clipboard history" { spawn "noctalia" "msg" "clipboard"; }
        Mod+Escape hotkey-overlay-title="lock session" { spawn "noctalia" "msg" "session" "lock"; }

        Mod+Q { close-window; }

        Mod+H { focus-column-left; }
        Mod+L { focus-column-right; }
        Mod+J { focus-window-down; }
        Mod+K { focus-window-up; }

        Mod+Shift+H { move-column-left; }
        Mod+Shift+L { move-column-right; }
        Mod+Shift+J { move-window-down; }
        Mod+Shift+K { move-window-up; }

        Mod+Ctrl+H { focus-monitor-left; }
        Mod+Ctrl+L { focus-monitor-right; }
        Mod+Ctrl+Shift+H { move-column-to-monitor-left; }
        Mod+Ctrl+Shift+L { move-column-to-monitor-right; }

        Mod+1 { focus-workspace 1; }
        Mod+2 { focus-workspace 2; }
        Mod+3 { focus-workspace 3; }
        Mod+4 { focus-workspace 4; }
        Mod+5 { focus-workspace 5; }
        Mod+Shift+1 { move-column-to-workspace 1; }
        Mod+Shift+2 { move-column-to-workspace 2; }
        Mod+Shift+3 { move-column-to-workspace 3; }
        Mod+Shift+4 { move-column-to-workspace 4; }
        Mod+Shift+5 { move-column-to-workspace 5; }

        Mod+R { switch-preset-column-width; }
        Mod+F { maximize-column; }
        Mod+Shift+F { fullscreen-window; }
        Mod+C { center-column; }
        Mod+Minus { set-column-width "-10%"; }
        Mod+Equal { set-column-width "+10%"; }

        Print { screenshot; }
        Ctrl+Print { screenshot-screen; }
        Alt+Print { screenshot-window; }

        XF86AudioRaiseVolume allow-when-locked=true { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%+"; }
        XF86AudioLowerVolume allow-when-locked=true { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-"; }
        XF86AudioMute allow-when-locked=true { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"; }

        Mod+Shift+E { quit; }
    }
  '';
}
