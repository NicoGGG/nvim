require("custom.term")

vim.api.nvim_create_user_command("FetchAWSLogs", function(opts)
  -- opts.fargs is a table of the arguments provided by the user
  require("custom.aws_logs").fetch_and_open(opts.fargs)
end, {
  nargs = "+", -- Still requires 1 or more arguments
  -- Add the completion option, pointing to the Lua function
  complete = function(arglead, cmdline, cursorpos)
    -- For simple cases where the first argument is unique and has no spaces,
    -- Neovim's context usually means this function is called correctly
    -- when completing the first argument. We directly call our completer.
    -- For more complex arg parsing/completion based on position, more logic needed here.
    return require("custom.aws_logs").complete_log_groups(arglead, cmdline, cursorpos)
  end,
  desc = "Fetch AWS logs: <log_group> <text_pattern> [hours_back]",
})

vim.api.nvim_create_user_command(
  "Jq", -- The name of the new command
  function(opts)
    require("custom.jq").execJq(opts)
  end,
  {
    nargs = 1, -- Requires exactly one argument (the filter)
    desc = "Filter entire buffer through jq using <filter>",
    -- We don't need completion for the jq filter itself here
  }
)
