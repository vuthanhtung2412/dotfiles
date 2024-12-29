return {
  "echasnovski/mini.surround",
  keys = {
    { "s", "<nop>", desc = "surround", mode = { "n", "v" } },
    { "S", "<nop>", mode = { "n", "v" } },
  },
  opts = {
    mappings = {
      add = "sa",
      delete = "sd",
      find = "sf",
      find_left = "sF",
      highlight = "sh",
      replace = "sr",
      update_n_lines = "sn",
    },
  },
}
