local config = {
  header = {
    "888888888888888888888888888888888888888888888888888888888888",
    "888888888888888888888888888888888888888888888888888888888888",
    "8888888888888888888888888P''  ''9888888888888888888888888888",
    "8888888888888888P'88888P          988888'9888888888888888888",
    "8888888888888888  '9888            888P'  888888888888888888",
    "888888888888888888bo '9  d8o  o8b  P' od88888888888888888888",
    "888888888888888888888bob 98'  '8P dod88888888888888888888888",
    "888888888888888888888888    db    88888888888888888888888888",
    "88888888888888888888888888      8888888888888888888888888888",
    "88888888888888888888888P'9bo  odP'98888888888888888888888888",
    "88888888888888888888P' od88888888bo '98888888888888888888888",
    "888888888888888888   d88888888888888b   88888888888888888888",
    "8888888888888888888oo8888888888888888oo888888888888888888888",
    "888888888888888888888888888888888888888888888888888888888888",
  },

  plugins = {
    init = {
      ["wakatime/vim-wakatime"] = {},
      ["gpanders/editorconfig.nvim"] = {},
      ["lewis6991/spaceless.nvim"] = {},
      ["sindrets/diffview.nvim"] = {}
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
        -- diagnostics
        null_ls.builtins.diagnostics.eslint_d,
        -- formatting
        null_ls.builtins.formatting.prettierd,
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.rustfmt,
      }
      config.on_attach = function(client)
        if client.resolved_capabilities.document_formatting then
          vim.api.nvim_create_autocmd("BufWritePre", {
            desc = "Auto format before save",
            pattern = "<buffer>",
            callback = vim.lsp.buf.formatting,
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
}

return config
