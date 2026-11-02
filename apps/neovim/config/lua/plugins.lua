vim.pack.add({
    { src = "https://github.com/wnkz/monoglow.nvim" },
})

require("monoglow").setup({
  on_colors = function(colors)
    colors.glow = "#fd1b7c"
  end
})

vim.pack.add({
    { src = "https://github.com/mason-org/mason.nvim" },
})

require("mason").setup({ PATH = "append" })

vim.pack.add({
    { src = "https://github.com/nvim-lualine/lualine.nvim" },
})

require("lualine").setup()

vim.pack.add({
    { src = "https://github.com/ibhagwan/fzf-lua" },
})

local actions = require("fzf-lua.actions")

require("fzf-lua").setup({
    winopts = {
        backdrop = 85,
    },

    keymap = {
        builtin = {
            ["<C-f>"] = "preview-page-down",
            ["<C-b>"] = "preview-page-up",
            ["<C-p>"] = "toggle-preview",
        },

        fzf = {
            ["ctrl-a"] = "toggle-all",
            ["ctrl-t"] = "first",
            ["ctrl-g"] = "last",
            ["ctrl-d"] = "half-page-down",
            ["ctrl-u"] = "half-page-up",
        },
    },

    actions = {
        files = {
            ["ctrl-q"] = actions.file_sel_to_qf,
            ["ctrl-n"] = actions.toggle_ignore,
            ["ctrl-h"] = actions.toggle_hidden,
            ["enter"] = actions.file_edit_or_qf,
        },
    },
})

vim.pack.add({
    {
        src = "https://github.com/saghen/blink.cmp",
        version = vim.version.range("^1"),
    },
})

require("blink.cmp").setup({
    fuzzy = {
        implementation = "lua",
    },

    signature = {
        enabled = true,
    },

    keymap = {
        preset = "default",

        ["<C-space>"] = {},
        ["<C-p>"] = {},
        ["<Tab>"] = {},
        ["<S-Tab>"] = {},

        ["<C-y>"] = {
            "show",
            "show_documentation",
            "hide_documentation",
        },

        ["<C-n>"] = {
            "select_and_accept",
        },

        ["<C-k>"] = {
            "select_prev",
            "fallback",
        },

        ["<C-j>"] = {
            "select_next",
            "fallback",
        },

        ["<C-b>"] = {
            "scroll_documentation_down",
            "fallback",
        },

        ["<C-f>"] = {
            "scroll_documentation_up",
            "fallback",
        },

        ["<C-l>"] = {
            "snippet_forward",
            "fallback",
        },

        ["<C-h>"] = {
            "snippet_backward",
            "fallback",
        },
    },

    appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "normal",
    },

    completion = {
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 200,
        },
    },

    cmdline = {
        keymap = {
            preset = "inherit",

            ["<CR>"] = {
                "accept_and_enter",
                "fallback",
            },
        },
    },

    sources = {
        default = {
            "lsp",
        },
    },
})
