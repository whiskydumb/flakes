{ pkgs, ... }:
let
  treesitter = pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [
    p.nix
    p.lua
    p.bash
    p.fish
    p.json
    p.toml
    p.yaml
    p.markdown
    p.markdown_inline
    p.git_config
    p.gitcommit
    p.diff
    p.vim
    p.vimdoc
  ]);
in
{
  programs.neovim = {
    enable = true;

    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    withRuby = false;
    withPython3 = false;
    withNodeJs = false;

    plugins = [ treesitter ];

    initLua = ''
      vim.g.mapleader = " "
      vim.g.maplocalleader = " "

      local o = vim.o

      o.number = true
      o.relativenumber = true
      o.cursorline = true
      o.signcolumn = "yes"
      o.scrolloff = 5
      o.wrap = false
      o.termguicolors = true

      o.mouse = "a"
      o.clipboard = "unnamedplus"
      o.confirm = true

      o.ignorecase = true
      o.smartcase = true

      o.expandtab = true
      o.shiftwidth = 2
      o.tabstop = 2
      o.softtabstop = 2
      o.smartindent = true

      o.undofile = true
      o.swapfile = false

      o.splitbelow = true
      o.splitright = true
      o.updatetime = 250
      o.timeoutlen = 400

      vim.cmd.colorscheme("nocturne")

      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          pcall(vim.treesitter.start, args.buf)
        end,
      })

      vim.api.nvim_create_autocmd("TextYankPost", {
        callback = function()
          local hl = vim.hl or vim.highlight
          hl.on_yank()
        end,
      })
    '';
  };
}
