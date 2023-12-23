return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
    end,
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
    },
    config = function()
        local wk = require("which-key")

        local mappings = {
            -- Basic commands
            ["w"] = { "Save Current Buffer" },
            ["<F5>"] = "Undo tree",
            ["e"] = "File Explorer",
            -- Telescope
            f = {
                name = "Telescope",
                f = "Find file",
                g = "Live grep"
            },

            -- Neotree
            n = {
                name = "Neotree",
                e = "Neotree Toggle",
                f = "Neotree Focus",
            },

            -- LSP
            c = {
                name = "Code",
                a = "Code Action",
                v = "Variable Rename",
                d = "Open Diagnostic Float"
            },

            -- Harpoon
            h = {
                name = "Harpoon",
                h = "List Hooks",
                a = "Add Current File To Hooks",
            },

            -- Git
            g = {
                name = "Git",
                s = "Git Status",
            },
        }
        local opts = { prefix = "<leader>" }

        local base_mappings = {
            ["C-p"] = "Fuzzy Finder",
        }

        wk.register(mappings, opts)
        -- wk.register(base_mappings, {})
    end
}