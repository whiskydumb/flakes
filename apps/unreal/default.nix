{ pkgs, lib, ... }:
let
  environment = pkgs.buildFHSEnv {
    name = "unreal-shell";
    targetPkgs =
      p: with p; [
        bash
        coreutils
        findutils
        gnugrep
        gnused
        gawk
        which
        procps
        git
        git-lfs
        curl
        wget
        unzip
        zip
        python3
        stdenv.cc.cc.lib
        zlib
        openssl
        icu
        krb5
        libuuid
        libGL
        vulkan-loader
        SDL2
        alsa-lib
        libpulseaudio
        libxkbcommon
        wayland
        libdrm
        xorg.libX11
        xorg.libXcursor
        xorg.libXrandr
        xorg.libXi
        xorg.libXinerama
        xorg.libXext
        xorg.libXfixes
        xorg.libXrender
        xorg.libXScrnSaver
        xorg.libXtst
        xorg.libxcb
        nss
        nspr
        dbus
        glib
        gtk3
        atk
        at-spi2-atk
        cups
        pango
        cairo
        fontconfig
        freetype
        expat
      ];
    runScript = "bash";
  };
  launch = pkgs.writeShellApplication {
    name = "unreal";
    text = ''
      root="''${UNREAL_HOME:-$HOME/Applications/Unreal}"
      editor="$root/current/Engine/Binaries/Linux/UnrealEditor"
      if [[ ! -x "$editor" ]]; then
        printf 'No selected Unreal installation. Run unreal-install <zip>, then unreal-select <version>.\n' >&2
        exit 1
      fi
      exec ${lib.getExe environment} -c 'exec "$@"' unreal "$editor" "$@"
    '';
  };
  manager =
    name: command:
    pkgs.writeShellApplication {
      inherit name;
      text = ''
        exec ${lib.getExe pkgs.python3} ${./manage.py} ${command} "$@"
      '';
    };
in
{
  home.packages = [
    environment
    launch
    (manager "unreal-install" "install")
    (manager "unreal-select" "select")
  ];
}
