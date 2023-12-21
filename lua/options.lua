-- Basic configs

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.wrap = false

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- Synchronizes the system clipboard with nvim's clipboard
vim.opt.clipboard = "unnamedplus"

-- Keep the cursor in the middle of the screen
vim.opt.scrolloff = 999
vim.opt.virtualedit = "block"

vim.opt.inccommand = "split"

vim.opt.ignorecase = true
vim.opt.termguicolors = true

-- Keymaps

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)

