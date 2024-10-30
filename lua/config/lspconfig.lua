local configs = require "nvchad.configs.lspconfig"
require "config.diagnostics"

local on_attach = configs.on_attach
local on_init = configs.on_init
local capabilities = configs.capabilities

local lspconfig = require "lspconfig"

local function setup_servers()
  lspconfig.clangd.setup {
    cmd = { "clangd", "--offset-encoding=utf-16" },
    on_init = on_init,
    --on_attach = function(client)
    --client.server_capabilities.documentFormattingProvider = false
    --client.server_capabilities.documentRangeFormattingProvider = false
    --on_attach()
    --end,
    on_attach = on_attach,
    capabilities = capabilities,
  }

  lspconfig.pylsp.setup {
    on_attach = on_attach,
    settings = {
      pylsp = {
        plugins = {
          -- formatter options
          black = { enabled = false },
          autopep8 = { enabled = false },
          yapf = { enabled = false },
          -- linter options
          pylint = { enabled = true, executable = "pylint" },
          pyflakes = { enabled = false },
          -- type checker
          pylsp_mypy = { enabled = true },
          -- auto-completion options
          jedi_completion = { fuzzy = true },
          -- import sorting
          pyls_isort = { enabled = true },
          pycodestyle = {
            enabled = true,
            ignore = { "E501", "E231" },
            maxLineLength = 120,
          },
        },
      },
    },
    flags = {
      debounce_text_changes = 200,
    },
    capabilities = capabilities,
  }
end

local function setup_diags()
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    signs = true,
    update_in_insert = false,
    underline = true,
  })
end

setup_servers()
setup_diags()
-- Show diagnostics in popup
vim.keymap.set("n", "<Leader>d", "<cmd>lua require('echo-diagnostics').echo_entire_diagnostic()<CR>")
vim.api.nvim_create_autocmd("CursorHold", { command = ":lua require('echo-diagnostics').echo_line_diagnostic()" })
