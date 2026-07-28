{ pkgs, ... }:
{
  home.packages = with pkgs; [
    sops
    age
    ssh-to-age
    mkpasswd
    kdePackages.ksshaskpass
  ];

  home.sessionVariables = {
    SSH_AUTH_SOCK = "/run/user/1000/ssh-agent";
    SSH_ASKPASS = "${pkgs.kdePackages.ksshaskpass}/bin/ksshaskpass";
    SSH_ASKPASS_REQUIRE = "prefer";
  };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings."*".addKeysToAgent = "yes";
  };

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

  services.ssh-agent.enable = true;
}
