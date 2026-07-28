{ pkgs, ... }:
{
  home.packages = with pkgs; [
    sops
    age
    ssh-to-age
    mkpasswd
  ];

  programs.bat.enable = true;

  programs.eza = {
    enable = true;
    icons = "auto";
    git = true;
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
    options = [ "--cmd cd" ];
  };

  programs.fd = {
    enable = true;
    hidden = true;
    ignores = [ ".git/" ];
  };

  programs.ripgrep.enable = true;

  programs.btop.enable = true;
  programs.htop.enable = true;

  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
