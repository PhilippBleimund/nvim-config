local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local null_ls = require "null-ls"

local sources = {
  null_ls.builtins.formatting.clang_format.with {
    extra_args = {
      "-style={BasedOnStyle: LLVM, AllowShortFunctionsOnASingleLine: None}",
    },
  },
  null_ls.builtins.formatting.stylua,
  -- install pip install --upgrade autopep8 to be able to use
  require "none-ls.formatting.autopep8",
  --null_ls.builtins.formatting.black.with {
  --  extra_args = {
  --    "--line-length=120",
  --  },
  --},
}

null_ls.setup {
  sources = sources,
  debug = true,
  on_attach = function(client, bufnr)
    if client.supports_method "textDocument/formatting" then
      vim.api.nvim_clear_autocmds {
        group = augroup,
        buffer = bufnr,
      }
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format { bufnr = bufnr }
        end,
      })
    end
  end,
}
