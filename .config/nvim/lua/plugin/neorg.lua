return {
   {
      "vhyrro/luarocks.nvim",
      priority = 1000, -- We'd like this plugin to load first out of the rest
      config = true, -- This automatically runs `require("luarocks-nvim").setup()`
   },

   {
      "nvim-neorg/neorg",
      version = "*", -- Pin Neorg to the latest stable release
      dependencies = {
         "luarocks.nvim",
         "pysan3/pathlib.nvim",
         "nvim-neorg/lua-utils.nvim",
         "nvim-neotest/nvim-nio",
         "nvim-lua/plenary.nvim",
      },
      lazy = false,
      config = function()
         require("neorg").setup {
            load = {
               ["core.defaults"] = {}, -- Loads default behaviour
               ["core.concealer"] = {}, -- Adds pretty icons to your documents
               ["core.syntax"] = {}, -- Enable better syntax highlighting
               ["core.integrations.treesitter"] = {}, -- Integrate with nvim-treesitter
               ["core.autocommands"] = {}, -- Handles the creation and management of Neovim's autocommands.
               ["core.highlights"] = {}, -- Handles the creation and management of highlight groups
               ["core.mode"] = {}, -- Modes are a way of isolating different parts of Neorg based on the current mode.
               ["core.dirman"] = { -- Manages Neorg workspaces
                  config = {
                     workspaces = {
                        notes = "~/notes",
                     },
                  },
               },
            },
         }
      end,
   },
}
