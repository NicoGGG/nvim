return {
  "kdheepak/lazygit.nvim",
  -- optional for floating window border decoration
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    { "<leader>gg", vim.cmd.LazyGit },
  },
  config = function()
    require("telescope").load_extension("lazygit")
    vim.g.lazygit_floating_window_scaling_factor = 1
  end,
}
