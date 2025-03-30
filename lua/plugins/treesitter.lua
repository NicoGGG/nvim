return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      {
        "hiphish/rainbow-delimiters.nvim",
        config = function()
          require("rainbow-delimiters.setup").setup({
            highlight = {
              "RainbowDelimiterYellow",
              "RainbowDelimiterBlue",
              "RainbowDelimiterOrange",
              "RainbowDelimiterGreen",
              "RainbowDelimiterViolet",
              "RainbowDelimiterCyan",
              "RainbowDelimiterRed",
            },
          })
        end,
      },
    },
    config = function()
      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      parser_config.ejs = {
        install_info = {
          url = "https://github.com/tree-sitter/tree-sitter-embedded-template.git",
          files = { "src/parser.c" },
          generate_requires_npm = true, -- if stand-alone parser without npm dependencies
          requires_generate_from_grammar = false,
        },
        filetype = "ejs",
      }
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "bash",
          "c",
          "lua",
          "vim",
          "vimdoc",
          "query",
          "python",
          "go",
          "html",
          "http",
          "json",
          "htmldjango",
          "css",
          "javascript",
          "typescript",
          "markdown",
          "markdown_inline",
          "rust",
        },
        auto_install = true,
        highlight = {
          enable = true,
          disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
        },
        indent = {
          enable = true,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-SPACE>",
            node_incremental = "<C-SPACE>",
            scope_incremental = "<C-s>",
            node_decremental = "<C-x>",
          },
        },
        textobjects = {
          select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,

            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["af"] = { query = "@function.outer", desc = "Select outer part of a function" },
              ["if"] = { query = "@function.inner", desc = "Select inner part of a function" },
              ["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
              ["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },
              ["aa"] = { query = "@parameter.outer", desc = "Select outer part of a parameter" },
              ["ia"] = { query = "@parameter.inner", desc = "Select inner part of a parameter" },
              -- You can optionally set descriptions to the mappings (used in the desc parameter of
              -- nvim_buf_set_keymap) which plugins like which-key display
              -- You can also use captures from other query groups like `locals.scm`
              ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
              ["id"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },
              ["ad"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
            },
            -- You can choose the select mode (default is charwise 'v')
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * method: eg 'v' or 'o'
            -- and should return the mode ('v', 'V', or '<c-v>') or a table
            -- mapping query_strings to modes.
            selection_modes = {
              ["@parameter.outer"] = "v", -- charwise
              ["@function.outer"] = "V", -- linewise
              ["@class.outer"] = "<c-v>", -- blockwise
            },
            -- If you set this to `true` (default is `false`) then any textobject is
            -- extended to include preceding or succeeding whitespace. Succeeding
            -- whitespace has priority in order to act similarly to eg the built-in
            -- `ap`.
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * selection_mode: eg 'v'
            -- and should return true of false
            include_surrounding_whitespace = true,
          },
        },
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
}
