return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-neotest/neotest-jest",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      local neotest = require("neotest")
      neotest.setup({
        adapters = {
          require("neotest-jest")({
            jestCommand = "yarn test --silent false",
            env = { CI = true },
            cwd = function(path)
              return vim.fn.getcwd()
            end,
          }),
        },
      })
      local nmap = function(keys, func, desc)
        if desc then
          desc = "Test: " .. desc
        end

        vim.keymap.set("n", keys, func, { desc = desc, silent = true })
      end
      nmap("<leader>tr", ":lua require('neotest').run.run()<CR>", "[T]est [R]un")
      nmap("<leader>tf", ":lua require('neotest').run.run(vim.fn.expand('%'))<CR>", "[T]est [F]ile")
    end,
  },
}
