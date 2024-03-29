local map = vim.api.nvim_set_keymap

-- <C-j> / <C-k> ... goto_next / goto_prev
map('n', '<C-j>', ':call LSPNextDiagnosticCycle()<CR>', {})
map('n', '<C-k>', ':call LSPPrevDiagnosticCycle()<CR>', {})
vim.cmd [[
  fun! LSPNextDiagnosticCycle()
    lua vim.lsp.diagnostic.goto_next()
  endfun

  fun! LSPPrevDiagnosticCycle()
    lua vim.lsp.diagnostic.goto_prev()
  endfun
]]

-- <leader>D ... set_loclist (diagnostics window)
map('n', '<leader>D', ':call LSPOpenDiagnostics()<CR>', { silent = true })
vim.cmd [[
  au BufReadPost quickfix nnoremap <silent> <buffer> <leader>D <C-w>c
]]
vim.cmd [[
  fun! LSPOpenDiagnostics()
    lua vim.lsp.diagnostic.set_loclist()
  endfun
]]

vim.cmd [[
  hi! LspDiagnosticsDefaultError guifg=#767676
  hi! LspDiagnosticsSignError guifg=#767676
  hi! LspDiagnosticsWarning guifg=#767676
  hi! LspDiagnosticsSignWarning guifg=#767676
  hi! LspDiagnosticsInformation guifg=#767676
  hi! LspDiagnosticsSignInformation guifg=#767676
  hi! LspDiagnosticsHint guifg=#767676
  hi! LspDiagnosticsSignHint guifg=#767676

  hi! DiagnosticErrorSymbol guisp=#bc6c4c guifg=#dc8c6c
  hi! DiagnosticWarningSymbol guisp=#bc6c9c guifg=#bc8cbc
  sign define LspDiagnosticsSignError text=░ texthl=DiagnosticErrorSymbol linehl= numhl=
  sign define LspDiagnosticsSignWarning text=░ texthl=DiagnosticWarningSymbol linehl= numhl=
  sign define LspDiagnosticsSignInformation text=░ texthl=DiagnosticWarningSymbol linehl= numhl=
  sign define LspDiagnosticsSignHint text=░ texthl=DiagnosticWarningSymbol linehl= numhl=
]]

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    virtual_text = false,
    signs = true,
    update_in_insert = false,
  }
)
