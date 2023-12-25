return {
  "sbdchd/neoformat",
  config = function()
    vim.g.neoformat_enabled_python = { "black" }
    vim.g.neoformat_enabled_htmldjango = { "djlint" }
    vim.g.neoformat_enabled_lua = { "stylua" }
    local fmt = vim.api.nvim_create_augroup("fmt", { clear = true })
    vim.api.nvim_create_autocmd("InsertLeave", {
      group = fmt,
      command = "undojoin | Neoformat | write",
    })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = fmt,
      callback = function()
        vim.cmd("Neoformat")
      end,
    })
    -- -- Old way of doing it. Was working so I leave it here just in case
    -- vim.cmd([[
    --   augroup fmt
    --     autocmd!
    --     " autocmd InsertLeave | write
    --     autocmd BufWritePre * undojoin | Neoformat
    --   augroup END
    -- ]])
  end,
}
