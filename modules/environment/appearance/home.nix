{
  config,
  lib,
  pkgs,
  ...
}:
let
  p = import ./palette.nix;
  hex = name: "#${p.${name}}";
  colors = {
    accent_bg_color = hex "blood";
    accent_fg_color = hex "onBlood";
    accent_color = hex "accent";
    destructive_bg_color = hex "blood";
    destructive_fg_color = hex "onBlood";
    destructive_color = hex "error";
    error_color = hex "error";
    error_bg_color = hex "error";
    error_fg_color = hex "background";
    success_color = hex "success";
    success_bg_color = hex "success";
    success_fg_color = hex "background";
    warning_color = hex "warning";
    warning_bg_color = hex "warning";
    warning_fg_color = hex "background";
    window_bg_color = hex "background";
    window_fg_color = hex "foreground";
    view_bg_color = hex "background";
    view_fg_color = hex "foreground";
    headerbar_bg_color = hex "surface";
    headerbar_fg_color = hex "foreground";
    headerbar_backdrop_color = hex "surface";
    sidebar_bg_color = hex "surface";
    sidebar_fg_color = hex "foreground";
    sidebar_backdrop_color = hex "surface";
    secondary_sidebar_bg_color = hex "background";
    secondary_sidebar_fg_color = hex "foreground";
    card_bg_color = hex "surface";
    card_fg_color = hex "foreground";
    dialog_bg_color = hex "surface";
    dialog_fg_color = hex "foreground";
    popover_bg_color = hex "surface";
    popover_fg_color = hex "foreground";
  };
  namedColors = lib.concatStringsSep "\n" (
    lib.mapAttrsToList (name: value: "@define-color ${name} ${value};") colors
  );
  cssVariables = lib.concatStringsSep "\n" (
    lib.mapAttrsToList (name: value: "  --${lib.replaceStrings [ "_" ] [ "-" ] name}: ${value};") colors
  );
  controls = ''
    button:not(.circular):not(.flat), entry { border-radius: 8px; }
    .dim-label { color: ${hex "muted"}; opacity: 1; }
  '';
  qtColors =
    disabled:
    lib.concatStringsSep ", " (
      map hex [
        (if disabled then "muted" else "foreground")
        "surface"
        "muted"
        "surface"
        "background"
        "surface"
        (if disabled then "muted" else "foreground")
        "foreground"
        (if disabled then "muted" else "foreground")
        "background"
        "background"
        "background"
        "blood"
        (if disabled then "muted" else "onBlood")
        "accent"
        "muted"
        "surface"
        "background"
        "surface"
        "foreground"
        "muted"
        "accent"
      ]
    );
  qtPalette = pkgs.writeText "whisky-qt-colors.conf" ''
    [ColorScheme]
    active_colors=${qtColors false}
    inactive_colors=${qtColors false}
    disabled_colors=${qtColors true}
  '';
  qtStyle = pkgs.writeText "whisky-qt.qss" ''
    QPushButton, QToolButton, QComboBox, QLineEdit, QSpinBox, QDoubleSpinBox {
      border-radius: 8px;
      padding: 5px 8px;
      border: 1px solid ${hex "surface"};
      background: ${hex "surface"};
      color: ${hex "foreground"};
    }
    QPushButton:focus, QLineEdit:focus, QComboBox:focus { border-color: ${hex "accent"}; }
    QPushButton:checked, QToolButton:checked { background: ${hex "blood"}; color: ${hex "onBlood"}; }
    QPushButton:disabled, QToolButton:disabled { color: ${hex "muted"}; }
    QMenu { background: ${hex "surface"}; color: ${hex "foreground"}; }
    QMenu::item:selected { background: ${hex "blood"}; color: ${hex "onBlood"}; border-radius: 6px; }
    QSlider::groove:horizontal { height: 4px; background: ${hex "surface"}; border-radius: 2px; }
    QSlider::sub-page:horizontal { background: ${hex "accent"}; border-radius: 2px; }
    QSlider::handle:horizontal { background: ${hex "foreground"}; width: 14px; margin: -5px 0; border-radius: 7px; }
  '';
  qtConfig = {
    Fonts = {
      general = "Geologica,11,-1,5,50,0,0,0,0,0";
      fixed = "Iosevka Nerd Font Mono,11,-1,5,50,0,0,0,0,0";
    };
    Appearance = {
      icon_theme = config.gtk.iconTheme.name;
      style = "Fusion";
      custom_palette = true;
      color_scheme_path = toString qtPalette;
      standard_dialogs = "xdgdesktopportal";
    };
    Interface.stylesheets = toString qtStyle;
  };
  ini = pkgs.formats.ini { };
in
{
  imports = [
    ./fonts.nix
    ./icons.nix
  ];
  gtk = {
    enable = true;
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
    gtk3 = {
      extraConfig.gtk-application-prefer-dark-theme = true;
      extraCss = namedColors + "\n" + controls;
    };
    gtk4.extraCss = namedColors + "\n:root {\n" + cssVariables + "\n}\n" + controls;
  };
  dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style.name = "Fusion";
  };
  xdg.configFile = {
    "qt5ct/qt5ct.conf".source = ini.generate "qt5ct.conf" qtConfig;
    "qt6ct/qt6ct.conf".source = ini.generate "qt6ct.conf" qtConfig;
    "uwsm/env.d/20-appearance.sh".text = ''
      export QT_QPA_PLATFORMTHEME=${lib.escapeShellArg config.home.sessionVariables.QT_QPA_PLATFORMTHEME}
      export XCURSOR_THEME=${lib.escapeShellArg config.home.pointerCursor.name}
      export XCURSOR_SIZE=${toString config.home.pointerCursor.size}
    '';
  };
}
