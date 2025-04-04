return {
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    lazy = true,
    config = false,
    init = function()
      -- Disable automatic setup, we are doing it manually
      vim.g.lsp_zero_extend_cmp = 0
      vim.g.lsp_zero_extend_lspconfig = 0
      -- Reserve a space in the gutter
      -- This will avoid an annoying layout shift in the screen
      vim.opt.signcolumn = "yes"
    end,
  },
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
    config = function()
      require("mason").setup()
      local opts = {
        ensure_installed = {
          "stylua",
          "black",
          "djlint",
          "goimports",
          "ansible-lint",
          "prettier",
          "eslint_d",
        },
      }
      -- copied from nvchad config to install all non LSP packages easily (not automatic tho)
      vim.api.nvim_create_user_command("MasonInstallAll", function()
        if opts.ensure_installed and #opts.ensure_installed > 0 then
          vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
        end
      end, {})

      vim.g.mason_binaries_list = opts.ensure_installed
    end,
  },
  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    commit = "b356f2c",
    event = "InsertEnter",
    dependencies = {
      { "L3MON4D3/LuaSnip" },
    },
    config = function()
      -- Here is where you configure the autocompletion settings.
      local lsp_zero = require("lsp-zero")
      lsp_zero.extend_cmp()

      -- And you can configure cmp even more, if you want to.
      local cmp = require("cmp")
      local cmp_action = lsp_zero.cmp_action()

      cmp.setup({
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        formatting = lsp_zero.cmp_format(),
        mapping = cmp.mapping.preset.insert({

          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
          }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif require("luasnip").expand_or_jumpable() then
              vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
            else
              fallback()
            end
          end),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif require("luasnip").jumpable(-1) then
              vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
            else
              fallback()
            end
          end),
          ["<C-k>"] = cmp.mapping({
            i = function()
              if cmp.visible() then
                cmp.abort()
              else
                cmp.complete()
              end
            end,
            c = function()
              if cmp.visible() then
                cmp.close()
              else
                cmp.complete()
              end
            end,
          }),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-u>"] = cmp.mapping.scroll_docs(-4),
          ["<C-d>"] = cmp.mapping.scroll_docs(4),
          ["<C-f>"] = cmp_action.luasnip_jump_forward(),
          ["<C-b>"] = cmp_action.luasnip_jump_backward(),
        }),
      })
    end,
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    cmd = { "LspInfo", "LspInstall", "LspStart" },
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "williamboman/mason-lspconfig.nvim", dependencies = "williamboman/mason.nvim" },
    },
    config = function()
      -- This is where all the LSP shenanigans will live
      local lsp_zero = require("lsp-zero")
      lsp_zero.extend_lspconfig()

      lsp_zero.on_attach(function(client, bufnr)
        -- see :help lsp-zero-keybindings
        -- to learn the available actions
        -- -- Configure auto format => see format plugin for config
        -- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
        -- if client.supports_method("textDocument/formatting") then
        --   vim.api.nvim_clear_autocmds({
        --     group = augroup,
        --     buffer = bufnr,
        --   })
        --   vim.api.nvim_create_autocmd("BufWritePre", {
        --     group = augroup,
        --     buffer = bufnr,
        --     callback = function()
        --       vim.lsp.buf.format({ bufnr = bufnr })
        --     end,
        --   })
        -- end
        lsp_zero.default_keymaps({ buffer = bufnr })
        local nmap = function(keys, func, desc)
          if desc then
            desc = "LSP: " .. desc
          end

          vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
        end
        -- Diagnostic keymaps
        nmap("[d", vim.diagnostic.goto_prev, "Go to previous diagnostic message")
        nmap("]d", vim.diagnostic.goto_next, "Go to next diagnostic message")
        nmap("<leader>cd", vim.diagnostic.open_float, "Open [D]iagnostic Float")
        nmap("<leader>cl", vim.diagnostic.setloclist, "Open Diagnostics [L]ist")

        -- See `:help K` for why this keymap
        nmap("K", vim.lsp.buf.hover, "Hover Documentation")
        nmap("<leader>k", function()
          vim.diagnostic.config({ virtual_lines = { current_line = true }, virtual_text = false })

          vim.api.nvim_create_autocmd("CursorMoved", {
            group = vim.api.nvim_create_augroup("line-diagnostics", { clear = true }),
            callback = function()
              vim.diagnostic.config({ virtual_lines = false, virtual_text = true })
              return true
            end,
          })
        end)
        nmap("<leader>cs", vim.lsp.buf.signature_help, "[S]ignature Documentation")

        -- Code navigation
        nmap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
        nmap("gD", require("telescope.builtin").lsp_type_definitions, "[G]oto Type [D]efinition")
        nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
        nmap("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
        nmap("<leader>cs", require("telescope.builtin").lsp_document_symbols, "Document [S]ymbols")
        nmap("<leader>cw", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace Symbols")
      end)
      lsp_zero.set_sign_icons({
        error = "✘",
        warn = "▲",
        hint = "⚑",
        info = "»",
      })
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "pyright",
          "gopls",
          "ts_ls",
          "volar",
          "rust_analyzer",
          "marksman",
          "bashls",
          "html",
          "cssls",
          "htmx",
          "ansiblels",
          "docker_compose_language_service",
          "terraformls",
          "eslint",
        },
        handlers = {
          lsp_zero.default_setup,
          ts_ls = function()
            require("lspconfig").ts_ls.setup({})
          end,
          lua_ls = function()
            -- (Optional) Configure lua language server for neovim
            local lua_opts = lsp_zero.nvim_lua_ls()
            require("lspconfig").lua_ls.setup(lua_opts)
          end,
          html = function()
            require("lspconfig").html.setup({
              filetypes = { "html", "htmldjango" },
            })
          end,
          htmx = function()
            require("lspconfig").html.setup({
              filetypes = { "html", "htmldjango" },
            })
          end,
          volar = function()
            require("lspconfig").html.setup({
              filetypes = { "vue" },
            })
            -- ts/js/vue
            require("lspconfig").volar.setup({
              filetypes = { "vue" },
              -- enable "take over mode" for typescript files as well: https://github.com/johnsoncodehk/volar/discussions/471
              -- filetypes = { "typescript", "javascript", "vue" },
            })
          end,
          -- volar = function()
          --   -- If you are using mason.nvim, you can get the ts_plugin_path like this
          --   local mason_registry = require("mason-registry")
          --   local vue_language_server_path = mason_registry.get_package("vue-language-server"):get_install_path()
          --     .. "/node_modules/@vue/language-server"
          --
          --   local lspconfig = require("lspconfig")
          --
          --   lspconfig.tsserver.setup({
          --     init_options = {
          --       plugins = {
          --         {
          --           name = "@vue/typescript-plugin",
          --           location = vue_language_server_path,
          --           languages = { "vue" },
          --         },
          --       },
          --     },
          --     filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
          --   })
          --
          --   -- No need to set `hybridMode` to `true` as it's the default value
          --   lspconfig.volar.setup({})
          -- end,

          -- terraformls = function()
          --   local capabilities = vim.lsp.protocol.make_client_capabilities()
          --   capabilities.textDocument.completion.completionItem.snippetSupport = true
          --   require("lspconfig").terraformls.setup({
          --     filetypes = { "terraform", "hcl", "tf", "terraform-vars" },
          --     capabilities = capabilities,
          --   })
          -- end,
        },
      })
    end,
  },
}
