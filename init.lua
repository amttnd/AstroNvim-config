local config = {
  plugins = {
    init = {
      ["wakatime/vim-wakatime"] = {},
    }
  },

  mappings = {
    n = {
      ["<leader>h"] = { "<cmd>set hlsearch!<cr>", desc = "Toggle Highlight" },
    }
  },
}

return config
