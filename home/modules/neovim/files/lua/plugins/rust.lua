return {
  'mrcjkb/rustaceanvim',
  version = '^6',
  init = function()
    -- Configure rustaceanvim here
    vim.g.rustaceanvim = {
      tools = {
        autoSetHints = true,
        inlay_hints = {
          show_parameter_hints = true,
          parameter_hints_prefix = 'in: ', -- "<- "
          other_hints_prefix = 'out: ', -- "=> "
        },
      },
      server = {
        on_attach = function(client, bufnr)
          local bufopts = {
            noremap = true,
            silent = true,
            buffer = bufnr,
          }
          vim.keymap.set('n', '<leader>st', '<Cmd>RustLsp hover actions<CR>', bufopts)

          vim.keymap.set('n', '<C-w>d', '<Cmd>lua vim.diagnostic.open_float()<CR>', bufopts)
        end,
      },
    }
  end,
  lazy = false,
}
