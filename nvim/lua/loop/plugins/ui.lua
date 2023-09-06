local ui = {
    -- Themes
    {
        'frenzyexists/aquarium-vim',
        priority = 1000,
        lazy = true
    },
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        lazy = true,
        priority = 1000
    },
    {
        'savq/melange-nvim',
        priority = 1000,
        lazy = true
    },
    {
        'kvrohit/mellow.nvim',
        priority = 1000,
        config = function()
            vim.cmd([[colorscheme mellow]])
        end
    },
    {
        'dasupradyumna/midnight.nvim',
        priority = 1000,
        lazy = true
    },
    {
        'wilmanbarrios/palenight.nvim',
        lazy = true,
        priority = 1000
    },
    {
        "sainnhe/sonokai",
        priority = 1000,
        lazy = true
    },
    {
        'NTBBloodbath/sweetie.nvim',
        lazy = true,
        priority = 1000,
    },
    {
        'folke/tokyonight.nvim',
        lazy = true,
        priority = 1000,
        opts = { style = 'moon' }
    },
    {
        "lunacookies/vim-substrata",
        priority = 1000,
        lazy = true
    },
    {
        'glepnir/zephyr-nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        lazy = true
    },
    {
        'zaldih/themery.nvim',
        event = "VeryLazy",
        config = function()
            require('themery').setup({
                themes = {
                    "aquarium",
                    "catppuccin",
                    "melange",
                    "mellow",
                    "midnight",
                    "palenight",
                    "sonokai",
                    "sweetie",
                    "substrata",
                    "tokyonight",
                    "zephyr"
                },
                live_preview = true
            })
        end,
    },

    --Cursorline
    {
        "gen740/SmoothCursor.nvim",
        config = function()
            require('loop.pconf.ui.smoothcursor')
        end,
        lazy = true,
        event = { "BufEnter", "BufNewFile", "BufReadPost" },
    },
    --Bufferline
    {
        "akinsho/bufferline.nvim",
        config = function()
            require('loop.pconf.ui.bufferline')
        end,
        lazy = true,
        event = "VeryLazy",
    },

    --Lualine
    {
        "nvim-lualine/lualine.nvim",
        config = function()
            require('loop.pconf.ui.lualine')
        end,
        lazy = true,
        event = "VeryLazy",
    },

    -- Indents

    {
        "lukas-reineke/indent-blankline.nvim",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require('loop.pconf.ui.indentline')
        end,
        lazy = true
    },

    {
        "echasnovski/mini.indentscope",
        config = function()
            require('mini.indentscope').setup()
        end,
        version = false, -- wait till new 0.7.0 release to put it back on semver
        event = { "BufReadPre", "BufNewFile" },
    },

    -- Neodim
    {
        "zbirenbaum/neodim",
        event = "LspAttach",
        config = function()
            require("neodim").setup({
                refresh_delay = 75,
                alpha = 0.75,
                blend_color = "#000000",
                hide = {
                    underline = true,
                    virtual_text = true,
                    signs = true,
                },
                priority = 128,
                disable = {},
            })
        end
    },
    -- Noice
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        config = function()
            require('loop.pconf.ui.noice')
        end,
        dependencies = {

            {
                "rcarriga/nvim-notify",
            },
            {
                "stevearc/dressing.nvim",
                lazy = true,
                init = function()
                    ---@diagnostic disable-next-line: duplicate-set-field
                    vim.ui.select = function(...)
                        require("lazy").load({ plugins = { "dressing.nvim" } })
                        return vim.ui.select(...)
                    end
                    ---@diagnostic disable-next-line: duplicate-set-field
                    vim.ui.input = function(...)
                        require("lazy").load({ plugins = { "dressing.nvim" } })
                        return vim.ui.input(...)
                    end
                end,
            },
        }
    },

    -- Navic
    {
        "SmiteshP/nvim-navic",
        lazy = true,
        config = function()
            require('nvim-navic').setup()
        end
    },
}

return ui

