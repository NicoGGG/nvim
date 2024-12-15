return {
  "folke/which-key.nvim",
  dependencies = {
    "echasnovski/mini.icons",
  },
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
    local ts = require("telescope.builtin")

    wk.add({
      { "<leader><F5>", desc = "Undo tree" },
      { "<leader>a", group = "Form[a]t" },
      { "<leader>ad", desc = "Autoformat [D]isable" },
      { "<leader>ae", desc = "Autoformat [E]nable" },
      { "<leader>c", group = "[C]ode" },
      { "<leader>cp", group = "Co[p]ilot" },
      { "<leader>cps", "<CMD>Copilot<CR>", desc = "Copilot [S]tatus" },
      { "<leader>cpt", "<CMD>Copilot suggestion toggle_auto_trigger<CR>", desc = "Copilot [T]oggle Auto Trigger" },
      { "<leader>f", group = "[F]ind with Telescope" },
      { "<leader>g", group = "[G]it" },
      { "<leader>gg", desc = "Lazy[G]it" },
      { "<leader>gc", ts.git_commits, desc = "Git [C]ommits" },
      { "<leader>gb", ts.git_bcommits, desc = "Git [B]uffer Commits" },
      { "<leader>h", group = "[H]arpoon" },
      { "<leader>ha", desc = "Harpoon [A]dd Current File" },
      { "<leader>hh", desc = "List [H]ooks" },
      { "<leader>n", group = "[N]eotree" },
      { "<leader>e", group = "N[e]otree toggle" },
      { "<leader>r", group = "[R]est" },
      { "<leader>rp", desc = "Send [P]review" },
      { "<leader>rr", desc = "Send [R]equest" },
      { "<leader>s", group = "Auto[s]ave" },
      { "<leader>sD", desc = "[D]iscard All Changes and Quit Buffer" },
      { "<leader>st", desc = "[T]oggle Autosave" },
      { "<leader>t", group = "[T]erminal" },
      { "<leader>v", group = "[V]env" },
      { "<leader>vc", desc = "[C]ached Venv" },
      { "<leader>vs", desc = "[S]elect Venv" },
      { "<leader>w", desc = "[W]rite Current Buffer" },
      { "<leader>y", group = "[Y]anking" },
    })
  end,
}
