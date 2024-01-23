return {
  "okuuva/auto-save.nvim",
  cmd = "ASToggle", -- optional for lazy loading on command
  event = { "InsertLeave", "TextChanged" }, -- optional for lazy loading on trigger events
  opts = {
    condition = function(buf)
      local fn = vim.fn

      -- don't save for special-buffers
      if fn.getbufvar(buf, "&buftype") ~= "" then
        return false
      end
      return true
    end, -- Option to disable autosave on all non-normal buffers
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
