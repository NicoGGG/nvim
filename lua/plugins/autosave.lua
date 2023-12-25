return {
  "Pocco81/auto-save.nvim",
  config = function()
    vim.keymap.set("n", "<leader>a", ":ASToggle<CR>")
    -- Next command allows to restore file to its initial state and quit,
    -- effectively doing a "!quit" if autosave was disabled
    vim.keymap.set("n", "<leader>aR", ":u0 | w | q<CR>")
  end,
}
