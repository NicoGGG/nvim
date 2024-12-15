return {
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    config = function()
      require("kanagawa").setup({
        colors = {
          theme = {
            all = {
              ui = {
                bg_gutter = "none",
              },
            },
          },
        },
        overrides = function(colors)
          local theme = colors.theme
          return {
            Normal = { bg = "none" },
            NormalFloat = { bg = "none" },
            FloatBorder = { bg = "none" },
            FloatTitle = { bg = "none" },

            -- Save an hlgroup with dark background and dimmed foreground
            -- so that you can use it where your still want darker windows.
            -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
            NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

            -- Popular plugins that open floats will link to NormalFloat by default;
            -- set their background accordingly if you wish to keep them dark and borderless
            LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
            MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
          }
        end,
      })
    end,
  },
  {
    "EdenEast/nightfox.nvim",
    config = function()
      require("nightfox").setup({
        options = {
          transparent = true,
        },
        -- groups = {
        --   all = {
        --     Normal = { bg = "none" },
        --     NormalFloat = { bg = "none" },
        --     FloatBorder = { bg = "none" },
        --     FloatTitle = { bg = "none" },
        --     NeoTreeNormal = { bg = "none" },
        --     NeoTreeNC = { bg = "none" },
        --     TelescopeNormal = { bg = "none" },
        --     TelescopeBorder = { bg = "none" },
        --     TelescopeTitle = { bg = "none" },
        --     NotifyBackground = { bg = "none" },
        --   },
        -- },
      })
    end,
  },
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("cyberdream").setup({
        -- Recommended - see "Configuring" below for more config options
        transparent = true,
        italic_comments = true,
        hide_fillchars = true,
        borderless_telescope = true,
      })
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      transparent_background = true,
      term_colors = true,
      integrations = {
        -- aerial = true, -- TODO: install this or outline
        diffview = true,
        mason = true,
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
            ok = { "italic" },
          },
          underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
            ok = { "underline" },
          },
          inlay_hints = {
            background = true,
          },
        },
        neotest = true,
        notify = true,
        nvim_surround = true,
        -- symbols_outline = true, -- TODO: install this or aerial
        telescope = true,
        which_key = true,
      },
      -- Hello
      -- NOTE: Hello
      -- TODO:
      -- WARN:
    },
  },
  -- {
  --   NOTE: Alternative to colorscheme native transparent if not present
  --   "xiyaowong/transparent.nvim",
  --   lazy = false,
  -- },
}
