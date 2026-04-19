local configs = require "nvchad.configs.lspconfig"
require "config.diagnostics"

local on_attach = configs.on_attach
local on_init = configs.on_init
local capabilities = configs.capabilities

local lspconfig = vim.lsp

-- Clangd with utf-16 fix
vim.lsp.config["clangd"] = {
  cmd = { "clangd", "--offset-encoding=utf-16" },
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
}

-- Pyright
vim.lsp.config["pyright"] = {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
}

-- Assembly LSP
vim.lsp.config["asm_lsp"] = {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
}

local function setup_servers()
  for name, config in pairs(vim.lsp.config) do
    -- Only start LSPs we defined above
    if config.on_attach == on_attach then
      vim.lsp.start(config)
    end
  end
end

local function setup_diags()
  vim.diagnostic.config {
    virtual_text = false,
    signs = true,
    update_in_insert = false,
    underline = true,
  }
end

setup_servers()
setup_diags()
-- Show diagnostics in popup
vim.keymap.set("n", "<Leader>d", "<cmd>lua require('echo-diagnostics').echo_entire_diagnostic()<CR>")
vim.api.nvim_create_autocmd("CursorHold", { command = ":lua require('echo-diagnostics').echo_line_diagnostic()" })
