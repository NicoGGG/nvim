vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>")

local term_state = {
  split = {
    buf = -1,
    win = -1,
  },
  floating = {
    buf = -1,
    win = -1,
  },
}
--- Creates a floating or split window.
--- @param type string: "split" or "floating" - default "split"
--- @return table: A table containing `buf` (buffer handle) and `win` (window handle).
local function create_window(type)
  if type ~= "floating" and type ~= "split" then
    return {}
  end
  local win_opts = {}
  local editor_width = vim.o.columns
  local editor_height = vim.o.lines
  if type == "split" then
    local split_direction = "below"
    local height_ratio = 0.22
    local win_height = math.floor(editor_height * height_ratio)
    win_opts = {
      height = win_height,
      split = split_direction,
    }
  else
    local height_ratio = 0.8
    local width_ratio = 0.8

    local win_height = math.floor(editor_height * height_ratio)
    local win_width = math.floor(editor_width * width_ratio)
    local row = math.floor((editor_height - win_height) / 2)
    local col = math.floor((editor_width - win_width) / 2)
    win_opts = {
      relative = "editor",
      width = win_width,
      height = win_height,
      row = row,
      col = col,
      style = "minimal",
      border = "rounded",
    }
  end
  local buf = nil
  if vim.api.nvim_buf_is_valid(term_state[type].buf) then
    buf = term_state[type].buf
  else
    buf = vim.api.nvim_create_buf(false, true) -- nofile, scratch buffer
  end
  local win = vim.api.nvim_open_win(buf, true, win_opts)

  return { buf = buf, win = win }
end

local toggle_split_terminal = function()
  if not vim.api.nvim_win_is_valid(term_state.split.win) then
    term_state.split = create_window("split")
    if vim.bo[term_state.split.buf].buftype ~= "terminal" then
      vim.cmd.term()
    end
  else
    vim.api.nvim_win_hide(term_state.split.win)
  end
end

local toggle_floating_terminal = function()
  if not vim.api.nvim_win_is_valid(term_state.floating.win) then
    term_state.floating = create_window("floating")
    if vim.bo[term_state.floating.buf].buftype ~= "terminal" then
      vim.cmd.term()
    end
  else
    vim.api.nvim_win_hide(term_state.floating.win)
  end
end

vim.api.nvim_create_user_command("Floaterminal", toggle_floating_terminal, {})
vim.api.nvim_create_user_command("Spliterminal", toggle_split_terminal, {})

-- -- Terminal Mappings
vim.keymap.set({ "n" }, "<leader>tf", "<CMD>Floaterminal<CR>", { desc = "Toggle [T]erminal [F]loating" })
vim.keymap.set({ "n", "t" }, "<C-_>", "<CMD>Spliterminal<CR>", { desc = "Toggle [T]erminal [S]plit" })

vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("term-open", { clear = true }),
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end,
})

-- -- This is an example shortcut to send to the terminal. NOTE: need to make channel work. Not needed for now
-- vim.keymap.set("n", "<leader>tfl", function()
--   vim.fn.chansend(term_state.floating.term_id, { "ls\r" })
-- end, { desc = "[T]erminal [L]S" })
