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
        p = {
          name = "Co[p]ilot",
          s = { "<CMD>Copilot<CR>", "Copilot [S]tatus" },
          t = { "<CMD>Copilot suggestion toggle_auto_trigger<CR>", "Copilot [T]oggle Auto Trigger" },
        },
        c = {
          name = "[C]hatGPT",
          c = { "<cmd>ChatGPT<CR>", "Chat" },
          e = {
            function()
              require("chatgpt").edit_with_instructions()
            end,
            "[E]dit with instruction",
            mode = { "n", "v" },
          },
          g = { "<cmd>ChatGPTRun grammar_correction<CR>", "[G]rammar Correction", mode = { "n", "v" } },
          t = { "<cmd>ChatGPTRun translate<CR>", "[T]ranslate", mode = { "n", "v" } },
          k = { "<cmd>ChatGPTRun keywords<CR>", "[K]eywords", mode = { "n", "v" } },
          d = { "<cmd>ChatGPTRun docstring<CR>", "[D]ocstring", mode = { "n", "v" } },
          a = { "<cmd>ChatGPTRun add_tests<CR>", "[A]dd Tests", mode = { "n", "v" } },
          o = { "<cmd>ChatGPTRun optimize_code<CR>", "[O]ptimize Code", mode = { "n", "v" } },
          s = { "<cmd>ChatGPTRun summarize<CR>", "[S]ummarize", mode = { "n", "v" } },
          f = { "<cmd>ChatGPTRun fix_bugs<CR>", "[F]ix Bugs", mode = { "n", "v" } },
          x = { "<cmd>ChatGPTRun explain_code<CR>", "E[x]plain Code", mode = { "n", "v" } },
          r = { "<cmd>ChatGPTRun roxygen_edit<CR>", "[R]oxygen Edit", mode = { "n", "v" } },
          l = { "<cmd>ChatGPTRun code_readability_analysis<CR>", "Code Readabi[l]ity Analysis", mode = { "n", "v" } },
        },
      },

      -- Harpoon
      h = {
        name = "[H]arpoon",
        h = "List [H]ooks",
        a = "Harpoon [A]dd Current File",
      },

      -- Git
      g = {
        name = "[G]it",
        g = "Lazy[G]it",
      },

      -- Autosave
      s = {
        name = "Auto[s]ave",
        t = "[T]oggle Autosave",
        D = "[D]iscard All Changes and Quit Buffer",
      },

      -- Rest
      r = {
        name = "[R]est",
        r = "Send [R]equest",
        p = "Send [P]review",
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
