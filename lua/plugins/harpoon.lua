-- Needed to configure harpoon keymaps in the keys of lazy config for the plugin
local harpoon

return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  lazy = false,
  config = function()
    harpoon = require("harpoon"):setup()
  end,
  keys = {
    {
      "<leader>ha",
      function()
        harpoon:list():append()
      end,
    },
    {
      "<leader>hh",
      function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
    },
    {
      "<leader>hj",
      function()
        harpoon:list():select(1)
      end,
    },
    {
      "<leader>hk",
      function()
        harpoon:list():select(2)
      end,
    },
    {
      "<leader>hl",
      function()
        harpoon:list():select(3)
      end,
    },
    {
      "<leader>hi",
      function()
        harpoon:list():select(4)
      end,
    },
  },
}
