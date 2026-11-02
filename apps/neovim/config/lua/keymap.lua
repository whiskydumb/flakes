vim.keymap.set("n", "<leader>e", "<Cmd>Explore<CR>")

local fzf = require("fzf-lua")

vim.keymap.set("n", "<leader><leader>", fzf.files)
vim.keymap.set("n", "<leader>/", fzf.live_grep)

local opts = {
    noremap = true,
    silent = true,
}

vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)

vim.keymap.set("n", "<leader>fo", vim.lsp.buf.format, opts)
