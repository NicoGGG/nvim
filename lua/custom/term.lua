local term_id = nil
local cwd = nil
local new_term = function()
  if not cwd then
    local current_buffer = vim.api.nvim_get_current_buf()
    local file_path = vim.api.nvim_buf_get_name(current_buffer)
    cwd = vim.fn.fnamemodify(file_path, ":p:h")
  end

  Snacks.terminal.toggle(nil, { cwd = cwd })
  term_id = vim.bo.channel
  vim.api.nvim_win_set_height(0, 15)
end

-- -- Terminal Mappings
vim.keymap.set({ "n", "t" }, "<C-_>", function()
  new_term()
end, { desc = "Toggle Terminal" })

-- This is an example shortcut to send to the terminal
vim.keymap.set("n", "<leader>tl", function()
  vim.fn.chansend(term_id, { "ls\r" })
end, { desc = "[T]erminal [L]S" })

-- Rerun last command
vim.keymap.set("n", "<leader>tr", function()
  vim.fn.chansend(term_id, { "\x1b\x5b\x41\r\n" })
end, { desc = "[T]erminal [R]erun last command" })

-- Winamax specific: yarn lint
vim.keymap.set("n", "<leader>twl", function()
  vim.fn.chansend(term_id, { "yarn lint\r" })
end, { desc = "[T]erminal [W]inamax yarn [L]int" })

vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("term-open", { clear = true }),
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end,
})
