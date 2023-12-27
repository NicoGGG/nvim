return {
  "sbdchd/neoformat",
  config = function()
    vim.g.neoformat_enabled_python = { "black" }
    vim.g.neoformat_enabled_htmldjango = { "djlint" }
    vim.g.neoformat_enabled_lua = { "stylua" }
    vim.g.neoformat_enabled_go = { "goimports" }
    local fmt = vim.api.nvim_create_augroup("fmt", { clear = true })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = fmt,
      -- As per https://github.com/sbdchd/neoformat/issues/134
      -- this autoformat on save even if the file is at its initial state in the undotree
      command = "try | undojoin | Neoformat | catch /E790/ | Neoformat | endtry",
    })
  end,
}
