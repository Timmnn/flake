return {
  'FabijanZulj/blame.nvim',
  lazy = false,
  config = function()
    require('blame').setup {}

    vim.keymap.set('n', '<leader>bv', ':BlameToggle virtual<CR>')
    vim.keymap.set('n', '<leader>bw', ':BlameToggle window<CR>')

    local wk = require 'which-key'
    wk.add {
      { '<leader>b', group = 'Blame' },
      { '<leader>bv', desc = 'Toggle Virtual' },
      { '<leader>bw', desc = 'Toggle Window' },
    }
  end,
}
