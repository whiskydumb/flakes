{ pkgs, nixosConfig, ... }:
{
  imports = [
    ./git.nix
    ./prompt.nix
  ];
  programs = {
    fish = {
      enable = true;
      interactiveShellInit = ''
        set -g fish_greeting
        fish_default_key_bindings
      '';
      shellAliases = {
        ls = "eza --group-directories-first";
        ll = "eza --long --header --git --icons --group-directories-first";
        la = "eza --long --all --header --git --icons --group-directories-first";
        lt = "eza --tree --level=2 --icons --group-directories-first";
      };
      functions.dev = {
        description = "Enter a development shell";
        body = ''
          if test (count $argv) -ne 1
            printf 'Usage: dev <cpp|node|rust|rust-windows>\n' >&2
            return 2
          end

          switch $argv[1]
            case cpp node rust rust-windows
            case '*'
              printf 'Unknown development shell: %s\n' "$argv[1]" >&2
              return 2
          end

          set -l flake_dir "$HOME/Projects/nix-config"
          if set -q NIX_DEV_FLAKE_DIR
            set flake_dir "$NIX_DEV_FLAKE_DIR"
          end
          if not test -f "$flake_dir/flake.nix"
            printf 'Flake not found in %s. Set NIX_DEV_FLAKE_DIR to your nix-config directory.\n' "$flake_dir" >&2
            return 1
          end

          command nix develop "path:$flake_dir#$argv[1]" -c fish
        '';
      };
    };
    gh.enable = true;
    bat.enable = true;
    eza = {
      enable = true;
      enableFishIntegration = false;
    };
    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };
    fd.enable = true;
    ripgrep.enable = true;
    fzf = {
      enable = true;
      enableFishIntegration = true;
      defaultCommand = "fd --type f --hidden --exclude .git";
      fileWidgetCommand = "fd --type f --hidden --exclude .git";
      changeDirWidgetCommand = "fd --type d --hidden --exclude .git";
      defaultOptions = [
        "--height=40%"
        "--layout=reverse"
        "--info=inline"
      ];
    };
    btop.enable = true;
    direnv = {
      enable = true;
      enableFishIntegration = true;
      nix-direnv = {
        enable = true;
        package = pkgs.nix-direnv.override { nix = nixosConfig.nix.package; };
      };
    };
  };
  xdg.configFile."fish/completions/dev.fish".text = ''
    complete -c dev -f -n '__fish_is_first_arg' -a 'cpp node rust rust-windows'
  '';
}
