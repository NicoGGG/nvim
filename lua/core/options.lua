-- Basic configs

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.wrap = false

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.list = true
vim.opt.listchars:append("eol:󱞣")
vim.opt.listchars:append("space:.")
vim.opt.fillchars = { eob = " " }

-- -- Synchronizes the system clipboard with nvim's clipboard
-- -- Disabled because it was causing issues of loss of focus and general slowness (this is a known issue of Wayland wl-clipboard)
-- -- Use <leader>r instead to copy system clipboard to nvim's clipboard
-- vim.opt.clipboard = "unnamed,unnamedplus"

-- Keep the cursor in the middle of the screen
vim.opt.scrolloff = 999
vim.opt.virtualedit = "block"

vim.opt.guicursor = "n-v-c-sm-ve:block,r-cr-o:hor20,i-ci:block-iCursor-blinkwait300-blinkon200-blinkoff150"

vim.opt.inccommand = "split"

vim.opt.ignorecase = true
vim.opt.termguicolors = true

-- Colorschemes
vim.cmd.colorscheme("nordfox")
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
