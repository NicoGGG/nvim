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
      -- Telescope
      f = {
        name = "[F]ind with Telescope",
      },

      -- Neotree
      n = {
        name = "[N]eotree",
      },

      -- LSP
      c = {
        name = "[C]ode",
        s = { "<CMD>Copilot<CR>", "Copilot [S]tatus" },
        t = { "<CMD>Copilot suggestion toggle_auto_trigger<CR>", "Copilot [T]oggle Auto Trigger" },
      },

      -- Harpoon
      h = {
        name = "[H]arpoon",
        h = "List Hooks",
        a = "[H]arpoon [A]dd Current File",
      },

      -- Git
      g = {
        name = "[G]it",
        s = "Git [S]tatus",
        g = "Lazy[G]it",
      },

      -- Autosave
      s = {
        name = "Auto[s]ave",
        t = "[T]oggle Autosave",
        D = "[D]iscard All Changes and Quit Buffer",
      },

      -- Venv (Python)
      v = {
        name = "[V]env",
        s = "[S]elect Venv",
        c = "[C]ached Venv",
      },
    }
    local opts = { prefix = "<leader>" }

    wk.register(mappings, opts)
  end,
}
