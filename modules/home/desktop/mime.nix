{ lib, osConfig, ... }:
let
  browser = [ "helium.desktop" ];
  files = [ "org.kde.dolphin.desktop" ];
  images = [ "com.interversehq.qView.desktop" ];
  media = [ "mpv.desktop" ];
  archives = [ "org.kde.ark.desktop" ];
  editor = [ "dev.zed.Zed.desktop" ];

  forTypes = types: app: lib.genAttrs types (_: app);
in
lib.mkIf osConfig.settings.desktop.enable {
  xdg.mimeApps = {
    enable = true;

    defaultApplications =
      { "inode/directory" = files; }
      // forTypes [
        "text/html"
        "x-scheme-handler/http"
        "x-scheme-handler/https"
        "x-scheme-handler/about"
        "application/pdf"
      ] browser
      // forTypes [
        "image/png"
        "image/jpeg"
        "image/gif"
        "image/webp"
        "image/svg+xml"
        "image/bmp"
        "image/tiff"
      ] images
      // forTypes [
        "video/mp4"
        "video/x-matroska"
        "video/webm"
        "video/quicktime"
        "video/x-msvideo"
        "audio/mpeg"
        "audio/flac"
        "audio/ogg"
        "audio/wav"
      ] media
      // forTypes [
        "application/zip"
        "application/x-tar"
        "application/gzip"
        "application/x-xz"
        "application/zstd"
        "application/x-7z-compressed"
        "application/vnd.rar"
      ] archives
      // forTypes [
        "text/plain"
        "text/markdown"
        "application/json"
        "application/xml"
      ] editor;
  };

  xdg.configFile."baloofilerc".text = ''
    [Basic Settings]
    Indexing-Enabled=false
  '';
}
