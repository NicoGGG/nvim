return {
  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 3000,
      background_colour = "#000000",
    },
  },
  {
    "folke/noice.nvim",
    config = function()
      require("noice").setup({
        -- add any options here
        routes = {
          {
            filter = {
              event = "msg_show",
              any = {
                { find = "%d+L, %d+B" },
                { find = "; after #%d+" },
                { find = "; before #%d+" },
                { find = "%d fewer lines" },
                { find = "%d more lines" },
              },
            },
            opts = { skip = true },
          },
        },
        lsp = {
          hover = {
            enabled = false,
          },
          signature = {
            enabled = false,
          },
        },
      })
    end,
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    requires = { "nvim-tree/nvim-web-devicons", opt = true },
    config = function()
      require("lualine").setup({
        options = {
          icons_enabled = true,
          component_separators = "|",
          section_separators = "",
        },
        sections = {
          lualine_x = {
            {
              require("noice").api.statusline.mode.get,
              cond = require("noice").api.statusline.mode.has,
              color = { fg = "#ff9e64" },
            },
          },
          lualine_a = {
            {
              "buffers",
            },
          },
        },
      })
    end,
  },
}
