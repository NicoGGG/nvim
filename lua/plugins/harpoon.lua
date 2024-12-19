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
      "<leader>h1",
      function()
        harpoon:list():select(1)
      end,
    },
    {
      "<leader>h2",
      function()
        harpoon:list():select(2)
      end,
    },
    {
      "<leader>h3",
      function()
        harpoon:list():select(3)
      end,
    },
    {
      "<leader>h4",
      function()
        harpoon:list():select(4)
      end,
    },
  },
}
