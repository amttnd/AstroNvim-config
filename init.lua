local config = {
  plugins = {
    init = {
      ["wakatime/vim-wakatime"] = {},
    },
    ["feline"] = function(config)
      local status_ok, feline = pcall(require, "feline.providers.vi_mode")
      if not status_ok then return config end
      local hl = require("core.status").hl
      config.components.active[1][1] = {
        provider = function() return " " .. feline.get_vim_mode() .. " " end,
        hl = hl.mode(),
      }
      return config
    end,
    ["null-ls"] = function(config)
      local status_ok, null_ls = pcall(require, "null-ls")
      if not status_ok then return config end
      config.sources = {
        -- code actions
        null_ls.builtins.code_actions.eslint,
        -- diagnostics
        null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.diagnostics.editorconfig_checker,
        -- formatting
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.rustfmt,
      }
      config.on_attach = function(client)
        if client.resolved_capabilities.document_formatting then
          vim.api.nvim_create_autocmd("BufWritePre", {
            desc = "Auto format before save",
            pattern = "<buffer>",
            callback = vim.lsp.buf.formatting_sync,
          })
        end
      end
      return config
    end,
    ["tree-sitter"] = function(config)
      config.ensure_installed = {
        "html",
        "css",
        "scss",
        "json",
        "javascript",
        "typescript",
        "tsx",
        "markdown",
        "rust",
        "sql",
        "regex",
        "yaml",
        "toml",
        "dockerfile",
        "proto",
        "graphql",
        "prisma",
        "lua",
      }
      return config
    end,
  },

  mappings = {
    n = {
      ["<leader>h"] = { "<cmd>set hlsearch!<cr>", desc = "Toggle Highlight" },
    },
  },
}

return config
