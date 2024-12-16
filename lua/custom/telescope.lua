local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local make_entry = require("telescope.make_entry")
local conf = require("telescope.config").values

local M = {}

-- live multigrep based on TJ example implementation: https://www.youtube.com/watch?v=xdXE1tOT-qg
M.live_multigrep = function(opts)
  opts = opts or {}
  opts.cwd = opts.cwd or vim.fn.getcwd()

  local finder = finders.new_async_job({
    command_generator = function(prompt)
      if not prompt or prompt == "" then
        return nil
      end

      local pieces = vim.split(prompt, "  ")
      local args = { "rg", "--no-heading", "--with-filename", "--smart-case", "--line-number", "--column" } -- Use ripgrep with working options for telescope

      if pieces[1] then
        table.insert(args, "-e")
        table.insert(args, pieces[1])
      end

      if pieces[2] then
        table.insert(args, "-g")
        table.insert(args, pieces[2])
      end

      return args
    end,

    entry_maker = make_entry.gen_from_vimgrep(opts),
    cwd = opts.cwd,
  })

  pickers
    .new(opts, {
      debounce = 200,
      prompt_title = "Multi Live Grep",
      finder = finder,
      previewer = conf.grep_previewer(opts),
      sorter = require("telescope.sorters").empty(),
    })
    :find()
end

return M