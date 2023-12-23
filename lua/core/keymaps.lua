-- Keymaps
vim.g.mapleader = " "

local map = vim.api.nvim_set_keymap
local opts = {}
-- Main operations
map("n", "<leader>w", "<cmd>w<CR>", opts)

-- Unbind default bindings for arrow keys
map('v', '<up>', '<nop>', opts)
map('v', '<down>', '<nop>', opts)
map('v', '<left>', '<nop>', opts)
map('v', '<right>', '<nop>', opts)

map("n", "<leader>e", ":Ex<CR>", opts)

-- Resize window panes, we can use those arrow keys
-- to help use resize windows - at least we give them some purpose
map('n', '<up>', '<cmd>resize +2<CR>', opts)
map('n', '<down>', '<cmd>resize -2<CR>', opts)
map('n', '<left>', '<cmd>vertical resize -2<CR>', opts)
map('n', '<right>', '<cmd>vertical resize +2<CR>', opts)

-- Text maps
-- ---------
-- Move a line of text Alt+[j/k]
map('n', '<M-j>', [[mz:m+<CR>`z]], opts)
map('n', '<M-k>', [[mz:m-2<CR>`z]], opts)
map('v', '<M-j>', [[:m'>+<CR>`<my`>mzgv`yo`z]], opts)
map('v', '<M-k>', [[:m'<-2<CR>`>my`<mzgv`yo`z]], opts)

-- Disable highlights
map('n', '<leader><CR>', '<cmd>noh<CR>', opts)
