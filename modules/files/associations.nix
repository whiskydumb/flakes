{ config, lib, ... }:
let
  textTypes = [
    "text/plain"
    "text/markdown"
    "text/x-log"
    "text/x-readme"
    "application/json"
    "application/ld+json"
    "application/toml"
    "text/x-toml"
    "application/yaml"
    "application/x-yaml"
    "text/yaml"
    "text/x-yaml"
    "application/xml"
    "text/xml"
    "text/x-ini"
    "text/x-config"
    "text/x-nix"
    "text/x-lua"
    "text/x-shellscript"
    "application/x-shellscript"
    "text/x-python"
    "text/x-rust"
    "text/rust"
    "text/x-c"
    "text/x-csrc"
    "text/x-chdr"
    "text/x-c++"
    "text/x-c++src"
    "text/x-c++hdr"
    "text/javascript"
    "application/javascript"
    "text/typescript"
    "text/css"
    "text/x-makefile"
    "text/x-cmake"
    "text/csv"
  ];
  forTypes = types: desktop: lib.genAttrs types (_: [ desktop ]);
  associations = {
    "inode/directory" = [ "org.gnome.Nautilus.desktop" ];
  }
  // forTypes [
    "application/pdf"
    "text/html"
    "x-scheme-handler/http"
    "x-scheme-handler/https"
  ] "helium.desktop"
  // forTypes [
    "image/png"
    "image/jpeg"
    "image/webp"
    "image/gif"
    "image/bmp"
    "image/tiff"
    "image/avif"
    "video/mp4"
    "video/x-matroska"
    "video/webm"
    "video/quicktime"
    "video/x-msvideo"
    "video/mpeg"
    "video/mp2t"
    "video/ogg"
    "audio/mpeg"
    "audio/flac"
    "audio/x-flac"
    "audio/ogg"
    "audio/opus"
    "audio/wav"
    "audio/x-wav"
    "audio/mp4"
    "audio/aac"
    "audio/x-matroska"
  ] "mpv.desktop"
  // forTypes textTypes "whisky-neovim.desktop";
in
{
  xdg.mimeApps = {
    enable = true;
    defaultApplications = associations;
    associations.added = associations;
  };
  xdg.desktopEntries.whisky-neovim = {
    name = "Neovim";
    genericName = "Text Editor";
    icon = "nvim";
    exec = "${lib.getExe config.programs.ghostty.package} -e ${lib.getExe config.programs.neovim.finalPackage} -- %F";
    terminal = false;
    noDisplay = true;
    categories = [
      "Utility"
      "TextEditor"
    ];
    mimeType = textTypes;
  };
  programs.mpv.config.image-display-duration = "inf";
}
