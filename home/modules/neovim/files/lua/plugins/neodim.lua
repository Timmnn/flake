return {
  'zbirenbaum/neodim',
  event = 'LspAttach',
  config = function()
    require('neodim').setup()
  end,
}
