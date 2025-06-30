-- lua/utils/aws_logs.lua
local M = {}

local known_log_groups = {
  "pkp/sitngo-planification-worker",
  "pkp/sitngo-subscription-rule",
}

M.complete_log_groups = function(arglead, cmdline, cursorpos)
  local matches = {}
  -- Match case-insensitively
  local lead_lower = arglead:lower()

  for _, log_group in ipairs(known_log_groups) do
    -- Check if the log group starts with the typed text
    if log_group:lower():sub(1, #lead_lower) == lead_lower then
      table.insert(matches, log_group)
    end
  end
  return matches
end

--- Fetches AWS CloudWatch logs, filters them with rg, and opens results in a new buffer.
--- Usage: :FetchAWSLogs <log_group> <text_pattern> [<from-hours-ago>]
-- @param args table: Arguments from the user command {log_group, text_pattern, [hours_back]}
M.fetch_and_open = function(args)
  local log_group = args[1]
  local text_pattern = args[2]
  local hours_back_str = args[3]

  if not log_group or log_group == "" then
    vim.notify("Log group name is required.", vim.log.levels.ERROR)
    return
  end
  if not text_pattern or text_pattern == "" then
    vim.notify("Text filter pattern is required.", vim.log.levels.ERROR)
    return
  end

  local hours_back = tonumber(hours_back_str) or 1 -- Default to 1 hour if not specified or invalid
  if hours_back <= 1 then
    hours_back = 1
  end

  local aws_region = "eu-west-3" -- Or make this configurable

  -- Check prerequisites
  if vim.fn.executable("aws") == 0 then
    vim.notify("aws command not found.", vim.log.levels.ERROR)
    return
  end
  if vim.fn.executable("rg") == 0 then
    vim.notify("rg command not found.", vim.log.levels.ERROR)
    return
  end

  -- Time calculation
  local current_time_seconds_utc = os.time(os.date("!*t"))
  local start_time_seconds_utc = current_time_seconds_utc - (3600 * hours_back)
  local start_time_ms_str = tostring(start_time_seconds_utc * 1000)

  -- Construct AWS part
  local aws_cmd_part = table.concat({
    "aws",
    "--region",
    aws_region,
    "logs",
    "filter-log-events",
    "--log-group-name",
    vim.fn.shellescape(log_group),
    "--start-time",
    start_time_ms_str,
    "--output",
    "json",
    -- "--query",
    -- "'events[*].message'", -- Get raw message strings, quoted
  }, " ")

  -- Construct rg part (simpler flags needed now)
  -- We only need to filter lines containing the pattern
  local rg_cmd_part = table.concat({
    "rg",
    "--color",
    "never", -- Ensure no color codes
    "--smart-case", -- Or remove if case-sensitive is always needed
    "-e",
    vim.fn.shellescape(text_pattern), -- Filter by the text pattern
    -- No line/column numbers needed here
  }, " ")

  print(aws_cmd_part)
  -- Combine the pipeline command, redirect stderr
  local full_command_string = aws_cmd_part .. " | jq '.events[]' -c | " .. rg_cmd_part .. " 2>&1"
  local command_to_run = { "zsh", "-c", full_command_string }

  vim.notify(
    "Fetching logs for '" .. log_group .. "' matching '" .. text_pattern .. "'...",
    vim.log.levels.INFO,
    { title = "AWS Logs" }
  )

  -- Run the command using systemlist
  local output_lines = vim.fn.systemlist(command_to_run)
  local exit_code = vim.v.shell_error

  -- Check for errors
  if exit_code ~= 0 then
    local error_output = vim.fn.system(command_to_run) -- Rerun with system to capture stderr better
    vim.notify(
      "Failed to fetch/filter logs (Exit: " .. exit_code .. ")",
      vim.log.levels.ERROR,
      { title = "AWS Logs Error" }
    )
    print("Command failed:\n" .. vim.inspect(command_to_run) .. "\nOutput/Error:\n" .. error_output)
    return
  end

  -- Check for no results
  if #output_lines == 0 then
    vim.notify("No log messages found matching the criteria.", vim.log.levels.WARN, { title = "AWS Logs" })
    return
  end

  -- Success! Open a new buffer and populate it
  vim.cmd("enew") -- Create new buffer
  local new_bufnr = vim.api.nvim_get_current_buf()

  -- Set buffer options
  vim.api.nvim_buf_set_option(new_bufnr, "bufhidden", "hide")
  vim.api.nvim_buf_set_option(new_bufnr, "buftype", "nofile")
  vim.api.nvim_buf_set_option(new_bufnr, "swapfile", false)
  -- Set filetype to jsonl (JSON Lines) or fallback to json
  -- Check `:checkhealth provider` to see if treesitter parser for jsonl exists
  vim.api.nvim_buf_set_option(new_bufnr, "filetype", "json") -- Or 'json' if jsonl highlighting isn't available

  -- Set buffer content (each matching JSON message string is one line)
  vim.api.nvim_buf_set_lines(new_bufnr, 0, -1, false, output_lines)
  vim.api.nvim_buf_set_option(new_bufnr, "modified", false) -- Mark as unmodified

  -- Optional: Move cursor to the top
  vim.api.nvim_win_set_cursor(0, { 1, 0 })

  vim.notify("Fetched " .. #output_lines .. " log messages.", vim.log.levels.INFO, { title = "AWS Logs" })
end

return M
