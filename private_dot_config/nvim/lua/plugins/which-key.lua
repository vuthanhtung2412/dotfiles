return {
  "folke/which-key.nvim",
  opts = {
    triggers = {
      { "<auto>", mode = "nxso" },
      -- this on for mini-surround.nvim
      { "s", mode = { "n", "v" } },
    },
  },
}
