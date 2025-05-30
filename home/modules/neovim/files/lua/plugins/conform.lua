return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones.
      local disable_filetypes = { c = true, cpp = true }
      if disable_filetypes[vim.bo[bufnr].filetype] then
        return nil
      else
        return {
          timeout_ms = 1500,
          lsp_format = 'fallback',
        }
      end
    end,
    formatters_by_ft = {
      sh = { 'shfmt', 'shellcheck' },
      lua = { 'stylua' },
      javascript = { 'prettierd', 'prettier', stop_after_first = true },
      javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
      typescript = { 'prettierd', 'prettier', stop_after_first = true },
      typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
      react = { 'prettierd', 'prettier', stop_after_first = true },
      rust = { 'rustfmt' },
      json = { 'jq', 'prettier', stop_after_first = true },
      jsonc = { 'jq', 'prettier', stop_after_first = true },
      python = { 'black', 'isort', stop_after_first = true },
      go = { 'gofmt', 'goimports', stop_after_first = true },
      cpp = { 'clang-format' },
      c = { 'clang-format' },
      java = { 'google-java-format' },
      html = { 'prettier' },
      css = { 'prettier' },
      scss = { 'prettier' },
      yaml = { 'prettier' },
      markdown = { 'prettier' },
      toml = { 'taplo' },
    },
  },
}
