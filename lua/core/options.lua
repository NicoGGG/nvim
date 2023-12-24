-- Basic configs

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.wrap = false

vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.list = true
vim.opt.listchars:append("eol:󱞣")
vim.opt.listchars:append("space:.")
vim.opt.fillchars = { eob = " " }

-- Synchronizes the system clipboard with nvim's clipboard
vim.opt.clipboard = "unnamedplus"

-- Keep the cursor in the middle of the screen
vim.opt.scrolloff = 999
vim.opt.virtualedit = "block"

vim.opt.inccommand = "split"

vim.opt.ignorecase = true
vim.opt.termguicolors = true

-- -- Autosave when going back to normal mode
-- -- This needs some more practice before I can use it without problems
-- vim.api.nvim_create_autocmd("InsertLeave", {
--   callback = function()
--     vim.cmd("write")
--   end,
-- })
