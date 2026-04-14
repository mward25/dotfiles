return {
  "kevinhwang91/nvim-ufo",
  dependencies = { "kevinhwang91/promise-async" },
  event = "BufReadPost",
  init = function()
    vim.opt.foldcolumn = '1'
    vim.opt.foldlevel = 99
    vim.opt.foldlevelstart = 99
    vim.opt.foldenable = true

    -- Declare foldingRange capability before any LSP client connects
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true
    }
    vim.lsp.config('*', { capabilities = capabilities })
  end,
  config = function()
    vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
    vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

    require('ufo').setup({
      close_fold_kinds_for_ft = { default = {} },  -- disable auto-closing any fold kinds
      provider_selector = function(_bufnr, _filetype, _buftype)
        return { 'lsp', 'treesitter' }
      end
    })
  end,
}
