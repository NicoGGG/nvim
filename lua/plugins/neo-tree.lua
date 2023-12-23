return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = { "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
        "nvim-lua/plenary.nvim",
    },
    config = function()
        vim.keymap.set("n", "<leader>ne", ":Neotree toggle<CR>")
        vim.keymap.set("n", "<leader>nf", ":Neotree focus<CR>")
    end
    -- Does not work for now, using config instead
    -- keys = function()
    --     local nt = require("neo-tree")
    --     return {
    --         { "<C-n", nt.toggle },
    --     }
    -- end
}
