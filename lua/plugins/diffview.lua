return {
  "sindrets/diffview.nvim",
  config = function()
    require("diffview").setup({
      diff_binaries = false,
    })
  end,
}
