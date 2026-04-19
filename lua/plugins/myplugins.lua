local plugins = {
  {
    "NeogitOrg/neogit",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "sindrets/diffview.nvim",        -- optional - Diff integration
      "nvim-telescope/telescope.nvim", -- optional
    },
    config = true,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "codelldb",
      },
    },
  },
  {
    "williamboman/mason-lspconfig",
    lazy = false,
    config = function()
      require("mason-lspconfig").setup {
        ensure_installed = {
          "lua_ls",
          "pyright",
          "clangd",
          -- "asm-lsp", -- has to be manually installed
        },
        automatic_installation = true,
      }
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "nvimtools/none-ls.nvim",
    },
    config = function()
      require("mason-null-ls").setup {
        ensure_installed = {
          "black",
          "isort",
          "stylua",
          "clang-format",
          "prettier",
          "autopep8",
        },
        automatic_installation = true,
      }
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "nvimtools/none-ls-extras.nvim",
    },
    event = "VeryLazy",
    requires = { { "neovim/nvim-lspconfig" }, { "nvim-lua/plenary.nvim" } },
    opts = function()
      require "config.null-ls"
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
    "matze/vim-move",
    lazy = false,
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
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "c",
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "python",
        "javascript",
      },
    },
  },
  {
    "stevearc/aerial.nvim",
    lazy = false,
    opts = {},
    -- Optional dependencies
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("aerial").setup {
        -- optionally use on_attach to set keymaps when aerial has attached to a buffer
        on_attach = function(bufnr)
          -- Jump forwards/backwards with '{' and '}'
          vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
          vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
        end,
      }
      -- You probably also want to set a keymap to toggle aerial
      vim.keymap.set("n", "<leader>at", "<cmd>AerialToggle!<CR>")
      vim.keymap.set("n", "<leader>aa", "<cmd>AerialOpen<CR>")
      vim.keymap.set("n", "<leader>ac", "<cmd>AerialClose<CR>")
    end,
  },
}
return plugins
