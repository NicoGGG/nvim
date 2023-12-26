return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = { "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
  config = function()
    vim.keymap.set("n", "<leader>ne", ":Neotree toggle left<CR>")
    vim.keymap.set("n", "<leader>nf", ":Neotree focus<CR>")
    vim.keymap.set("n", "<leader>nb", ":Neotree toggle buffers right<CR>")
  end,
}
