{ lib, pkgs, ... }:
let
  palette = import ../appearance/palette.nix;
  theme = pkgs.replaceVars ./qml/Theme.qml palette;
in
{
  home.packages = [
    pkgs.blueman
    pkgs.libnotify
  ];
  programs.quickshell = {
    enable = true;
    activeConfig = "whisky";
    configs.whisky = pkgs.runCommand "whisky-shell" { } ''
      cp -r ${./qml} "$out"
      chmod -R u+w "$out"
      cp ${theme} "$out/Theme.qml"
      ln -s ${../appearance/wallpaper.png} "$out/wallpaper.png"
    '';
    systemd = {
      enable = true;
      target = "graphical-session.target";
    };
    package = pkgs.symlinkJoin {
      name = "quickshell-whisky";
      paths = [ pkgs.quickshell ];
      inherit (pkgs.quickshell) meta;
      nativeBuildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram "$out/bin/quickshell" \
          --prefix XDG_DATA_DIRS : "${
            lib.makeSearchPath "share" [
              pkgs.adwaita-icon-theme
              pkgs.nixos-icons
            ]
          }"
      '';
    };
  };
  systemd.user.services.quickshell.Unit.PartOf = [ "graphical-session.target" ];
}
