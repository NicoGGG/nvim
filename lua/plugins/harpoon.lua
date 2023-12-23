-- Needed to configure harpoon keymaps in the keys of lazy config for the plugin
local harpoon

return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        harpoon = require("harpoon"):setup()
    end,
    keys = {
        { "<leader>ha", function() harpoon:list():append() end },
        { "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end },
        { "<C-h>",      function() harpoon:list():select(1) end },
        { "<C-j>",      function() harpoon:list():select(2) end },
        { "<C-k>",      function() harpoon:list():select(3) end },
        { "<C-i>",      function() harpoon:list():select(4) end },
    }
}
