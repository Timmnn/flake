require 'options'

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)
require('lazy').setup({ { import = 'plugins' } }, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
  root = vim.fn.stdpath 'data' .. '/lazy',
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

require('nvim-treesitter.parsers').get_parser_configs().fusion = {
  install_info = {
    url = '/home/timm/Dev/fusion3/treesitter-fusion/', -- Local path or Git URL
    files = { 'src/parser.c' }, -- or parser.cc if C++
    -- optionally, if you have a scanner
    -- generate_requires_npm = false,
    -- requires_generate_from_grammar = true,
  },
  filetype = 'fusion', -- This should match the filetype you define below
}

vim.filetype.add {
  extension = {
    fu = 'fusion',
  },
}
