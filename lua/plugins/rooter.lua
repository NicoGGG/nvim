return {
  "notjedi/nvim-rooter.lua",
  config = function()
    require("nvim-rooter").setup({
      rooter_patterns = { ".git", ".venv", "main.go", "package.json" },
      manual = true,
    })
  end,
}
