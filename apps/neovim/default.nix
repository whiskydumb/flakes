{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    extraPackages = with pkgs; [
      git
      fzf
      ripgrep
      fd
      wl-clipboard
      lua-language-server
    ];
  };
  xdg.configFile = {
    "nvim/init.lua".source = ./config/init.lua;
    "nvim/lua" = {
      source = ./config/lua;
      recursive = true;
    };
    "nvim/lsp" = {
      source = ./config/lsp;
      recursive = true;
    };
  };
  home.activation.nvimPackLock = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ ! -e ${lib.escapeShellArg "${config.xdg.configHome}/nvim/nvim-pack-lock.json"} ]; then
      run ${pkgs.coreutils}/bin/install -Dm644 ${./config/nvim-pack-lock.json} \
        ${lib.escapeShellArg "${config.xdg.configHome}/nvim/nvim-pack-lock.json"}
    fi
  '';
}
