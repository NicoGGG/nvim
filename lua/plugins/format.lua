return {
  "sbdchd/neoformat",
  config = function()
    vim.g.neoformat_enabled_python = { "black" }
    vim.g.neoformat_enabled_toml = { "taplo" }
    vim.g.neoformat_enabled_htmldjango = { "djlint" }
    vim.g.neoformat_enabled_lua = { "stylua" }
    vim.g.neoformat_enabled_go = { "goimports" }
    vim.g.neoformat_enabled_rust = { "rustfmt" }
    vim.g.neoformat_enabled_html = { "prettier" }
    vim.g.neoformat_enabled_javascript = { "eslint_d", "prettier" }
    vim.g.neoformat_enabled_typescript = { "eslint_d", "prettier" }
    local fmt = vim.api.nvim_create_augroup("fmt", { clear = true })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = fmt,
      -- As per https://github.com/sbdchd/neoformat/issues/134
      -- this autoformat on save even if the file is at its initial state in the undotree
      command = "try | undojoin | Neoformat | catch /E790/ | Neoformat | endtry",
    })
    -- <leader>ad to disable autoformat on save
    vim.api.nvim_set_keymap(
      "n",
      "<leader>ad",
      ":autocmd! fmt BufWritePre<CR>",
      { noremap = true, silent = true, desc = "Disable autoformat on save" }
    )

    -- <leader>ac to enable autoformat on save
    vim.api.nvim_set_keymap(
      "n",
      "<leader>ae",
      ":autocmd fmt BufWritePre try | undojoin | Neoformat | catch /E790/ | Neoformat | endtry<CR>",
      { noremap = true, silent = true, desc = "Enable autoformat on save" }
    )
  end,
}
