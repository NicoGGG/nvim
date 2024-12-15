local term_id = 0
vim.keymap.set("n", "<leader>tn", function()
  vim.cmd.new()
  vim.cmd.term()
  vim.api.nvim_win_set_height(0, 15)

  term_id = vim.bo.channel
end, { desc = "[T]erminal [N]ew" })

vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]])

-- This is an example shortcut to send to the terminal
vim.keymap.set("n", "<leader>tl", function()
  vim.fn.chansend(term_id, { "ls\r\n" })
end, { desc = "[T]erminal [L]S" })

-- This is an example shortcut to send to the terminal
vim.keymap.set("n", "<leader>tr", function()
  vim.fn.chansend(term_id, { "\x1b\x5b\x41\r\n" })
end, { desc = "[T]erminal [R]erun last command" })

vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("term-open", { clear = true }),
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end,
})
