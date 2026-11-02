{
  lib,
  pkgs,
  nixosConfig,
  ...
}:
let
  files =
    if nixosConfig.virtualisation.vmware.guest.enable then
      pkgs.symlinkJoin {
        name = "nautilus-vm";
        paths = [ pkgs.nautilus ];
        nativeBuildInputs = [ pkgs.makeWrapper ];
        postBuild = ''
          wrapProgram "$out/bin/nautilus" --set LIBGL_ALWAYS_SOFTWARE 1
          desktopFile="$out/share/applications/org.gnome.Nautilus.desktop"
          cp --remove-destination "${pkgs.nautilus}/share/applications/org.gnome.Nautilus.desktop" "$desktopFile"
          substituteInPlace "$desktopFile" --replace-fail 'Exec=nautilus' "Exec=$out/bin/nautilus"
          for service in org.gnome.Nautilus.service org.freedesktop.FileManager1.service; do
            serviceFile="$out/share/dbus-1/services/$service"
            cp --remove-destination "${pkgs.nautilus}/share/dbus-1/services/$service" "$serviceFile"
            substituteInPlace "$serviceFile" --replace-fail '${pkgs.nautilus}/bin/nautilus' "$out/bin/nautilus"
          done
        '';
      }
    else
      pkgs.nautilus;
in
{
  imports = [ ./associations.nix ];
  home.packages = [ files ];
  dconf.settings = {
    "org/gnome/desktop/interface".color-scheme = "prefer-dark";
    "org/gtk/gtk4/settings/file-chooser".sort-directories-first = true;
    "org/gnome/nautilus/preferences" = {
      default-folder-viewer = "list-view";
      show-image-thumbnails = "local-only";
      click-policy = "double";
    };
    "org/gnome/nautilus/list-view".use-tree-view = true;
  };
  wayland.windowManager.hyprland.extraConfig = lib.mkAfter ''
    hl.bind("SUPER + E", hl.dsp.exec_cmd("uwsm app -- nautilus"))
  '';
}
