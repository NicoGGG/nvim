return {
  "okuuva/auto-save.nvim",
  cmd = "ASToggle", -- optional for lazy loading on command
  event = { "InsertLeave", "TextChanged" }, -- optional for lazy loading on trigger events
  opts = {
    debounce_delay = 3000, -- delay after which a pending save is executed
    -- Option to disable autosave on all non-normal buffers
    condition = function(buf)
      if vim.bo[buf].buftype ~= "" then
        return false
      end
    end,
  },
  keys = {
    -- vim.keymap.set("n", "<leader>st", ":ASToggle<CR>"),
    -- -- Next command allows to restore file to its initial state and quit,
    -- -- effectively doing a "!quit" if autosave was disabled
    -- vim.keymap.set("n", "<leader>sD", ":u0 | w | q<CR>"),
    { "<leader>st", ":ASToggle<CR>" },
    { "<leader>sD", ":u0 | w | q<CR>" },
  },
}
