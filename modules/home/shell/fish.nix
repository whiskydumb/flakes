{ config, ... }:
let
  configDir = "${config.home.homeDirectory}/.flakes";
in
{
  home.sessionVariables.NIXOS_CONFIG = configDir;

  programs.fish = {
    enable = true;

    shellAliases = {
      cat = "bat";
      ls = "eza";
      ll = "eza -l --icons --git";
      la = "eza -la --icons --git";
      lt = "eza --tree --level=2 --icons";

      nixcfg = "cd ${configDir}";

      rebuild = "sudo nixos-rebuild switch --flake ${configDir}#(hostname)";
      update = "nix flake update --flake ${configDir}";

      cleanup = "sudo nix-collect-garbage -d; and nix-collect-garbage -d";
    };

    loginShellInit = ''
      if test (tty) = /dev/tty1
        exec niri-session
      end
    '';

    interactiveShellInit = ''
      set fish_greeting
      fish_vi_key_bindings

      # clear scrollback on Ctrl-L
      bind ctrl-l 'clear; commandline -f repaint'
      bind -M insert ctrl-l 'clear; commandline -f repaint'
    '';
  };
}
