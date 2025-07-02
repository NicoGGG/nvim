local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local make_entry = require("telescope.make_entry")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

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

-- NOTE: keep this just in case to reuse
-- M.winamax_log_finder = function(opts)
--   opts = opts or {}
--   opts.cwd = opts.cwd or vim.fn.getcwd()
--
--   -- Configuration Variables
--   local log_group = "pkp/sitngo-planification-worker" -- Your log group name
--   local aws_region = "eu-west-3" -- Specify your AWS region if not default
--
--   local finder = finders.new_async_job({
--     command_generator = function(prompt)
--       if not prompt or prompt == "" then
--         return nil
--       end
--
--       -- Time calculation (Ensure this is correct - using 12 hours ago based on your code)
--       local current_time_seconds_utc = os.time(os.date("!*t"))
--       local hours_ago = 12 -- How many hours back to search
--       local previous_time_seconds_utc = current_time_seconds_utc - (3600 * hours_ago)
--       local start_time_ms_str = tostring(previous_time_seconds_utc * 1000)
--       -- print("DEBUG Lua Timestamp - Current Time UTC (sec): " .. current_time_seconds_utc)
--       -- print("DEBUG Lua Timestamp - " .. hours_ago .. " Hours Ago UTC (sec): " .. previous_time_seconds_utc)
--       -- print("DEBUG Lua Timestamp - Calculated Start Time (ms string): " .. start_time_ms_str)
--
--       local escaped_prompt = vim.fn.shellescape(prompt)
--
--       -- Construct AWS part string (Using the fixed query quoting)
--       local aws_cmd_part = table.concat({
--         "aws",
--         "--region",
--         aws_region,
--         "logs",
--         "filter-log-events",
--         "--log-group-name",
--         vim.fn.shellescape(log_group),
--         "--start-time",
--         start_time_ms_str,
--         "--output",
--         "text",
--         "--query",
--         "'events[*].message'", -- Query with single quotes
--       }, " ")
--
--       -- Construct rg part string
--       local rg_cmd_part = table.concat({
--         "rg",
--         "--line-number",
--         "--column",
--         "--no-heading",
--         "--color",
--         "never",
--         "--smart-case",
--         "-e",
--         escaped_prompt,
--       }, " ")
--
--       -- Combine, redirect stderr
--       local full_command_string = aws_cmd_part .. " | " .. rg_cmd_part .. " 2>&1"
--
--       local command_to_run = { "sh", "-c", full_command_string }
--       -- print("DEBUG: Telescope AWS Logs Command: " .. vim.inspect(command_to_run))
--       return command_to_run
--     end, -- End of command_generator
--
--     entry_maker = function(line)
--       -- The entry_maker that parses "lnum:col:text"
--       local parts = vim.split(line, ":", { plain = true, max = 3, trimempty = false })
--       local entry = {
--         display = line,
--         ordinal = line,
--         value = line,
--         filename = "AWS Logs",
--         lnum = 0,
--         col = 0,
--         text = line,
--       }
--       if #parts == 3 then
--         local potential_lnum = tonumber(parts[1])
--         local potential_col = tonumber(parts[2])
--         local potential_text = parts[3]
--         if potential_lnum and potential_col and potential_text and potential_text ~= "" then
--           entry.filename = "AWS Logs"
--           entry.lnum = potential_lnum
--           entry.col = potential_col
--           entry.text = potential_text
--           entry.display = potential_text -- Show only JSON text in results list
--           entry.ordinal = string.format("%010d:%05d", entry.lnum, entry.col)
--           entry.value = { raw = line, filename = entry.filename, lnum = entry.lnum, col = entry.col, text = entry.text }
--         end
--       end
--       return entry
--     end, -- End of entry_maker
--
--     cwd = opts.cwd,
--   }) -- End of finder definition
--
--   pickers
--     .new(opts, {
--       debounce = 500,
--       prompt_title = "AWS Logs Grep (" .. log_group .. ")",
--       finder = finder,
--       entry_maker = entry_maker, -- Make sure the entry_maker is assigned here too
--       -- Previewer is disabled based on your request to put it aside
--       -- previewer = conf.grep_previewer(opts),
--       sorter = conf.generic_sorter(opts), -- Or require("telescope.sorters").empty()
--
--       -- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
--       -- * Updated Action Mapping Section                 *
--       -- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
--       attach_mappings = function(prompt_bufnr, map)
--         -- Replace the default selection action (<CR>)
--         actions.select_default:replace(function()
--           local entry = action_state.get_selected_entry()
--           if not entry then
--             print("No entry selected")
--             return
--           end
--
--           -- Close Telescope window first
--           actions.close(prompt_bufnr)
--
--           -- Extract the log text (use .text field from the parsed value table)
--           local log_text = entry.value and entry.value.text or ""
--
--           if log_text == "" then
--             -- Fallback if .value.text wasn't populated correctly
--             log_text = entry.text or entry.value or ""
--             if log_text == "" then
--               print("Selected entry has no text content.")
--               return
--             end
--             print("Warning: Using fallback text for entry.")
--           end
--
--           -- Create a new buffer in the current window
--           vim.cmd("enew")
--
--           -- Get the new buffer's handle
--           local new_bufnr = vim.api.nvim_get_current_buf()
--
--           -- Set buffer options for a scratch buffer
--           vim.api.nvim_buf_set_option(new_bufnr, "bufhidden", "hide")
--           vim.api.nvim_buf_set_option(new_bufnr, "buftype", "nofile")
--           vim.api.nvim_buf_set_option(new_bufnr, "swapfile", false)
--           -- Set filetype to JSON for syntax highlighting
--           -- If your logs aren't JSON, change this or remove it
--           vim.api.nvim_buf_set_option(new_bufnr, "filetype", "json")
--           -- Optional: Prevent modifications
--           -- vim.api.nvim_buf_set_option(new_bufnr, 'modifiable', false)
--
--           -- Prepare content as a table of lines (important for nvim_buf_set_lines)
--           -- Handles if the log_text itself contains newlines, though unlikely for JSON logs
--           local content_lines = vim.split(log_text, "\n", { plain = true, trimempty = false })
--
--           -- Set the content of the new buffer
--           vim.api.nvim_buf_set_lines(new_bufnr, 0, -1, false, content_lines)
--
--           -- Optional: Move cursor to the top of the new buffer
--           vim.api.nvim_win_set_cursor(0, { 1, 0 })
--
--           print("Opened log entry in new buffer.")
--         end)
--         return true -- Indicate that mappings were attached/modified
--       end,
--       -- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
--       -- * End of Updated Section                   *
--       -- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
--     })
--     :find()
-- end -- End of M.winamax_log_finder

return M
