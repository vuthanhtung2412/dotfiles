-- ~/.config/nvim/lua/plugins/auto-save.lua

return {
  "pocco81/auto-save.nvim",
  event = { "InsertLeave", "TextChanged" },
  opts = {
    condition = function(buf)
      local fn = vim.fn
      local utils = require("auto-save.utils.data")

      -- Don't save if it's a Harpoon buffer
      if vim.bo[buf].filetype == "harpoon" then
        return false
      end

      -- Don't save non-normal buffers
      if vim.bo[buf].buftype ~= "" then
        return false
      end

      -- Default modifiable check
      if fn.getbufvar(buf, "&modifiable") ~= 1 then
        return false
      end

      -- Add any filetype exclusions if needed
      local excluded_filetypes = {
        -- file type to exclude from auto save
      }
      if utils.not_in(fn.getbufvar(buf, "&filetype"), excluded_filetypes) then
        return true
      end

      return false
    end,
    noautocmd = true,
  },
  config = function(_, opts)
    require("auto-save").setup(opts)

    -- Optional: Add any additional keymaps or commands here
    -- Example: Toggle auto-save
    vim.api.nvim_set_keymap(
      "n",
      "<leader>as",
      ":ASToggle<CR>",
      { noremap = true, silent = true, desc = "Toggle auto-save" }
    )
  end,
}
