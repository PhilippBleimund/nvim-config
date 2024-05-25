require "nvchad.mappings"
local MiniMap = require "mini.map"

local M = {}

M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = {
      "<cmd> DapToggleBreakpoint <CR>",
      "Add breakpoint at line",
      ["<leader>dr"] = {
        "<cmd> DapContinue <CR>",
        "Start or continue the debugger",
      },
    },
  },
}

vim.keymap.set("n", "<Leader>mc", MiniMap.close, { desc = "MiniMap close" })
vim.keymap.set("n", "<Leader>mf", MiniMap.toggle_focus, { desc = "MiniMap toggle focus" })
vim.keymap.set("n", "<Leader>mo", MiniMap.open, { desc = "MiniMap open" })
vim.keymap.set("n", "<Leader>mr", MiniMap.refresh, { desc = "MiniMap refresh" })
vim.keymap.set("n", "<Leader>ms", MiniMap.toggle_side, { desc = "MiniMap toggle side" })
vim.keymap.set("n", "<Leader>mt", MiniMap.toggle, { desc = "MiniMap toggle" })

return M
