local M = {}
M.execJq = function(opts)
  -- opts.args contains the single argument string provided by the user (the filter)
  local jq_filter = opts.args

  -- Optional: Check if jq is available
  if vim.fn.executable("jq") == 0 then
    vim.notify("jq command not found in PATH.", vim.log.levels.ERROR)
    return
  end

  -- Escape the filter argument to be safe for shell execution
  -- The '1' argument is important for special shell characters like ! % #
  local escaped_filter = vim.fn.shellescape(jq_filter, 1)

  -- Construct the command string to filter the whole buffer (%)
  local command_string = "%!jq " .. escaped_filter

  -- Execute the command
  vim.notify("Running: " .. command_string, vim.log.levels.INFO)
  vim.cmd(command_string)

  -- Note: Direct vim.cmd('%!...') doesn't easily allow capturing jq's exit code
  -- or handling empty output gracefully like the previous detailed Lua function did.
  -- If jq fails or returns nothing, the buffer might be cleared or show an error.
  -- Use 'u' (undo) if the result is unexpected.
end

return M
