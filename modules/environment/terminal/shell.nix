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
}
