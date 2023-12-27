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
        g = "Live grep",
      },

      -- Neotree
      n = {
        name = "Neotree",
        e = "Neotree Filesystem Toggle",
        f = "Neotree Focus",
        b = "Neotree Buffers Toggle",
      },

      -- LSP
      c = {
        name = "Code",
        a = "Code Action",
        r = "Variable Rename",
        d = "Open Diagnostic Float",
        c = {
          name = "Copilot",
          c = { "<CMD>Copilot<CR>", "Copilot Status" },
          t = { "<CMD>Copilot suggestion toggle_auto_trigger<CR>", "Copilot Toggle Auto Trigger" },
        },
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
        g = "LazyGit",
      },

      -- Autosave
      a = {
        name = "Autosave",
        t = "Toggle Autosave",
        R = "Discard All Changes and Quit Buffer",
      },
    }
    local opts = { prefix = "<leader>" }

    wk.register(mappings, opts)
  end,
}
