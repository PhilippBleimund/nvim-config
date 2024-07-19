local plugins = {
  {
    "NeogitOrg/neogit",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration
      "nvim-telescope/telescope.nvim", -- optional
    },
    config = true,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "clangd",
        "clang-format",
        "codelldb",
        "black",
        "isort",
        "stylua",
      },
    },
  },
  {
    "williamboman/mason-lspconfig",
    lazy = false,
    config = function()
      require("mason-lspconfig").setup {
        ensure_installed = { "lua_ls", "ruff_lsp", "jedi_language_server", "pylsp" },
      }
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    opts = {
      handlers = {},
    },
  },
  {
    "mfussenegger/nvim-dap",
    config = function(_, _) end,
  },
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      local dap = require "dap"
      local dapui = require "dapui"
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "config.lspconfig"
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    event = "VeryLazy",
    requires = { { "neovim/nvim-lspconfig" }, { "nvim-lua/plenary.nvim" } },
    opts = function()
      require "config.null-ls"
    end,
  },
  {
    "matze/vim-move",
    lazy = false,
  },
  {
    "echasnovski/mini.map",
    version = false,
    lazy = false,
    config = function()
      require "config.miniMap"
    end,
  },
  {
    "seblj/nvim-echo-diagnostics",
    config = function()
      require("echo-diagnostics").setup {
        show_diagnostic_number = true,
        show_diagnostic_source = false,
      }
    end,
  },
  {
    "ojroques/nvim-osc52",
    config = function()
      require("osc52").setup()
      local function copy()
        if vim.v.event.operator == "y" and vim.v.event.regname == "" then
          require("osc52").copy_register '"'
        end
      end

      vim.api.nvim_create_autocmd("TextYankPost", { callback = copy })
    end,
  },
}
return plugins
