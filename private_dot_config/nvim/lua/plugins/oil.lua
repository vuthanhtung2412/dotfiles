return {
  "stevearc/oil.nvim",
  enabled = false,
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    keymaps = {
      -- Ctrl + h/l are saved for pane navigation
      ["<C-h>"] = false,
      ["<C-l>"] = false,
      ["<C-v>"] = { "actions.select", opts = { vertical = true } },
      ["P"] = { "actions.preview", mode = "n" },
      ["<C-L>"] = "actions.refresh",
      -- Since h and l is already taken for text navigation
      ["L"] = { "actions.select", mode = "n" },
      ["H"] = { "actions.parent", mode = "n" },
    },
  },
  -- Optional dependencies
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
  keys = {
    {
      "<leader>o",
      function()
        require("oil").toggle_float()
      end,
      desc = "Oil",
    },
    {
      "<leader>O",
      function()
        require("oil").toggle_float()
        require("oil").discard_all_changes()
      end,
      desc = "Oil (clear buf)",
    }
  },
}
