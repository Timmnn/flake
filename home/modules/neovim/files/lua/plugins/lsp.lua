return {
  {
    'neovim/nvim-lspconfig',
    config = function()
      local lspconfig = require 'lspconfig'
      -- Shared on_attach function for all LSPs
      local on_attach = function(client, bufnr)
        -- Keymap for showing type of variable under cursor
        vim.keymap.set('n', '<leader>st', function()
          vim.lsp.buf.hover()
        end, { buffer = bufnr, desc = 'Show type of variable' })

        vim.keymap.set('n', 'gd', function()
          vim.lsp.buf.definition()
        end, { buffer = bufnr, desc = 'Show type of variable' })
      end

      -- Setup for Lua
      lspconfig.lua_ls.setup {
        on_attach = on_attach,
      }

      -- Setup for Rust with specific settings
      lspconfig.rust_analyzer.setup {
        on_attach = on_attach,
        settings = {
          ['rust-analyzer'] = {
            checkOnSave = true,
            inlayHints = {
              enable = true,
              parameterHints = true,
              typeHints = true,
            },
            completion = {
              autoimport = {
                enable = true, -- Automatically insert imports for completions
              },
            },
            diagnostics = {
              experimental = {
                enable = true, -- Enable experimental diagnostics
              },
            },
            lens = {
              enable = true, -- Enable code lens for references and implementations
            },
            procMacro = {
              enable = true, -- Enable procedural macro support
            },
          },
        },
      }

      lspconfig.pest_ls.setup {
        on_attach = on_attach,
        filetypes = { 'pest' },
        settings = {
          pest = {
            -- Add any pest-specific settings here if needed
          },
        },
      }

      lspconfig.typescript.setup {
        on_attach = on_attach,
        filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
        root_dir = lspconfig.util.root_pattern('package.json', 'tsconfig.json', '.git'),
      }

      -- Setup for Python
      lspconfig.pyright.setup {
        on_attach = on_attach,
      }

      -- Setup for Java
      lspconfig.jdtls.setup {
        on_attach = on_attach,
      }

      -- Setup for C/C++
      lspconfig.clangd.setup {
        on_attach = on_attach,
      }

      -- Setup for Go
      lspconfig.gopls.setup {
        on_attach = on_attach,
      }

      -- Setup for HTML
      lspconfig.html.setup {
        on_attach = on_attach,
      }

      -- Setup for CSS
      lspconfig.cssls.setup {
        on_attach = on_attach,
      }

      -- Setup for Emmet
      lspconfig.emmet_ls.setup {
        on_attach = on_attach,
        filetypes = { 'html', 'css', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
        init_options = {
          html = {
            options = {
              -- Enable Emmet abbreviations in HTML
              ['bem.enabled'] = true, -- Enable BEM support
              ['output.selfClosingStyle'] = 'xhtml', -- Use self-closing tags
            },
          },
          css = {
            options = {
              -- Enable Emmet in CSS
              ['bem.enabled'] = true,
            },
          },
        },
      }
    end,
  },
  {
    'pmizio/typescript-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    opts = {},
  },
}
