-- Keymaps
vim.g.mapleader = " "

local map = vim.api.nvim_set_keymap
local opts = {}
-- -- Basic operations
-- Save with leader w to avoid mistyping ":"
map("n", "<leader>w", "<cmd>w<CR>", opts)
-- Disable highlights
map("n", "<leader><CR>", "<cmd>noh<CR>", opts)
-- Paste without copying the deleted text when in visualmode
map("v", "<leader>p", '"_dP', opts)
-- -- Remap Ctrl-C to Esc because autosave works with Esc but Esc sometimes lags, especially in WSL. Moreover, Ctrl-C is more practical to hit on the keyboard
-- -- Turns out the lag comes from tmux, not vim. But I still prefer Ctrl-C for now.
-- -- It could be useful to have a mapping for back to normal mode without auto-save anyway
-- -- USING CAPS LOCK AS ESCAPE KEY INSTEAD
-- map("i", "<C-c>", "<Esc>", opts)

-- Unbind default bindings for arrow keys
map("v", "<up>", "<nop>", opts)
map("v", "<down>", "<nop>", opts)
map("v", "<left>", "<nop>", opts)
map("v", "<right>", "<nop>", opts)

-- Going back to navigation. Replaced by neo-tree show current
-- map("n", "<leader>e", ":Ex<CR>", opts)

-- Resize window panes, we can use those arrow keys
-- to help use resize windows - at least we give them some purpose
map("n", "<up>", "<cmd>resize +2<CR>", opts)
map("n", "<down>", "<cmd>resize -2<CR>", opts)
map("n", "<left>", "<cmd>vertical resize -2<CR>", opts)
map("n", "<right>", "<cmd>vertical resize +2<CR>", opts)

-- Text maps
-- ---------
-- Move a line of text Alt+[j/k]
map("n", "<M-j>", [[mz:m+<CR>`z]], opts)
map("n", "<M-k>", [[mz:m-2<CR>`z]], opts)
map("v", "<M-j>", [[:m'>+<CR>`<my`>mzgv`yo`z]], opts)
map("v", "<M-k>", [[:m'<-2<CR>`>my`<mzgv`yo`z]], opts)

-- Save from system to neovim clipboard
map("n", "<leader>yi", "<cmd>call setreg('@', getreg('+'))<CR>", { desc = "Save from system into neovim clipboard" })
-- Save from neovim to system clipboard
map("n", "<leader>ya", "<cmd>call setreg('+', getreg('@'))<CR>", { desc = "Save from neovim out to system clipboard" })
-- Yank directly to system clipboard
map("v", "<leader>yy", '"+y', { desc = "Yank directly to system clipboard" })
-- Paste from system clipboard
map("n", "<leader>yp", '"+p', { desc = "Paste from system clipboard" })
