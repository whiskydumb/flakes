{ config, ... }:
let
  home = config.home.homeDirectory;
in
{
  xdg.userDirs = {
    enable = true;
    createDirectories = true;

    desktop = "${home}/Desktop";
    documents = "${home}/Documents";
    download = "${home}/Downloads";
    music = "${home}/Music";
    pictures = "${home}/Pictures";
    videos = "${home}/Videos";
    publicShare = "${home}/Public";
    templates = "${home}/Templates";
  };
}
