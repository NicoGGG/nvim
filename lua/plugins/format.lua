return {
  "sbdchd/neoformat",
  config = function()
    vim.g.neoformat_enabled_python = { "black" }
    vim.g.neoformat_enabled_htmldjango = { "djlint" }
    vim.g.neoformat_enabled_lua = { "stylua" }
    vim.cmd([[
      augroup fmt
        " autocmd!
        autocmd BufWritePre * undojoin | Neoformat
      augroup END
    ]])
  end,
}
