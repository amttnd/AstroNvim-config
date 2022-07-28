local config = {
  plugins = {
    init = {
      ["wakatime/vim-wakatime"] = {},
    },
    ["feline"] = function(config)
      local status_ok, feline = pcall(require, "feline.providers.vi_mode")
      if not status_ok then return config end
      local C = require "default_theme.colors"
      local hl = require("core.status").hl
      config.components.active[1][1] = {
        provider = function()
          return ' '..feline.get_vim_mode()..' '
        end,
        hl = hl.mode()
      }
      return config
    end
  },

  mappings = {
    n = {
      ["<leader>h"] = { "<cmd>set hlsearch!<cr>", desc = "Toggle Highlight" },
    }
  },
}

return config
