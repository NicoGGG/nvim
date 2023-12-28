return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    -- or                              , branch = '0.1.x',
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup()
    end,
    keys = function()
      local ts = require("telescope.builtin")
      return {
        { "<leader>fb", ts.buffers, desc = "[F]ind [B]uffers" },
        { "<leader>fh", ts.help_tags, desc = "[F]ind [H]elp" },
        { "<leader>fo", ts.oldfiles, desc = "[F]ind [O]ld files" },
        { "<leader>ff", ts.find_files, desc = "[F]ind [F]ile" },
        { "<C-p>", ts.git_files, desc = "Search Git Files (Fuzzy search)" },
        { "<leader>fg", ts.live_grep, desc = "[F]ind by [G]rep" },
        { "<leader>fw", ts.grep_string, desc = "[F]ind current [W]ord" },
        { "<leader>fd", ts.diagnostics, desc = "[F]ind [D]iagnostics" },
        { "<leader>fr", ts.resume, desc = "[F]ind [R]esume" },
      }
    end,
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      -- This is your opts table
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({
              -- even more opts
            }),

            -- pseudo code / specification for writing custom displays, like the one
            -- for "codeactions"
            -- specific_opts = {
            --   [kind] = {
            --     make_indexed = function(items) -> indexed_items, width,
            --     make_displayer = function(widths) -> displayer
            --     make_display = function(displayer) -> function(e)
            --     make_ordinal = function(e) -> string
            --   },
            --   -- for example to disable the custom builtin "codeactions" display
            --      do the following
            --   codeactions = false,
            -- }
          },
        },
      })
      -- To get ui-select loaded and working with telescope, you need to call
      -- load_extension, somewhere after setup function:
      require("telescope").load_extension("ui-select")
    end,
  },
}
