local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
parser_config.fusion4 = {
  install_info = {
    --url = 'https://github.com/Timmnn/tree-sitter-fusion4',
    url = '/home/timm/Dev/tree-sitter-fusion4',
    files = { 'src/parser.c' },
    branch = 'main',
  },
  filetype = 'fusion4',
}

local parser_dir = vim.fn.stdpath 'data' .. '/treesitter_parsers'
vim.fn.mkdir(parser_dir, 'p')

vim.api.nvim_create_augroup('fusion4_ft', { clear = true })
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  group = 'fusion4_ft',
  pattern = '*.fu',
  callback = function()
    vim.bo.filetype = 'fusion4'
  end,
})

return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'nvim-treesitter/playground',
    },
    opts = {
      ensure_installed = { 'bash', 'c', 'html', 'lua', 'vimdoc', 'fusion4' },
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
      parser_install_dir = parser_dir,
    },
  },
}
