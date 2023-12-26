return {
  "Pocco81/auto-save.nvim",
  config = function()
    vim.keymap.set("n", "<leader>a", ":ASToggle<CR>")
    -- Next command allows to restore file to its initial state and quit,
    -- effectively doing a "!quit" if autosave was disabled
    vim.keymap.set("n", "<leader>aR", ":u0 | w | q<CR>")
    -- -- Option to disable auto save on harpoon ui buffers only
    -- local opts = {
    --   condition = function(buf)
    --     if vim.bo[buf].filetype == "harpoon" then
    --       return false
    --     end
    --   end,
    -- }

    -- Option to disable autosave on all non-normal buffers
    local opts = {
      condition = function(buf)
        if vim.bo[buf].buftype ~= "" then
          return false
        end
      end,
    }
    require("auto-save").setup(opts)
  end,
}
