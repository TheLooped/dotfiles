local editor = {
    -- File Explorer
    {
        "nvim-neo-tree/neo-tree.nvim",
        event = "VimEnter",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        },
        config = function()
            require('loop.pconf.editor.neo-tree')
        end
    },

    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        lazy = true,
        cmd = "Telescope",
        dependencies = {
            { "nvim-tree/nvim-web-devicons" },
            { "nvim-lua/plenary.nvim" },
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        },
    },

    {
        "nvim-treesitter/nvim-treesitter",
        lazy = true,
        build = function()
            if #vim.api.nvim_list_uis() ~= 0 then
                vim.api.nvim_command("TSUpdate")
            end
        end,
        event = "BufReadPost",
        dependencies = {
            {
                "nvim-treesitter/nvim-treesitter-textobjects"
            },
            {
                "JoosepAlviste/nvim-ts-context-commentstring"
            },
            {
                "hiphish/rainbow-delimiters.nvim",
            },
            {
                "nvim-treesitter/nvim-treesitter-context",
            },
            {
                "windwp/nvim-ts-autotag",
            },
            {
                "abecodes/tabout.nvim",
                config = function()
                    require("loop.pconf.editor.tabout")
                end
            },
        },
    },

    -- Search And Replace
    {
        'AckslD/muren.nvim',
        config = true,
        event = "VeryLazy",
        lazy = true
    },

    -- Comments
    {
        'numToStr/Comment.nvim',
        config = true,
        event = "VeryLazy",
        lazy = true,
    },
    -- Pairs
    {
        'echasnovski/mini.pairs',
        config = true,
        event = { "BufEnter", "BufNewFile", "BufReadPost", "InsertEnter" },
        version = false,
    },
    -- Surround
    {
        "kylechui/nvim-surround",
        config = true,
        version = "", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        lazy = true,
    },

    -- Peeking
    {
        'nacro90/numb.nvim',
        config = true,
    },
    -- Split Join
    {
        'Wansmer/treesj',
        lazy = true,
        keys = { '<space>j', '<space>s' },
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        config = function()
            require('treesj').setup()
        end,
    },

    -- Grapple
    {
        "cbochs/grapple.nvim",
        event = { "VeryLazy", "BufReadPost", "BufEnter" },
        config = function()
            require("loop.pconf.editor.grapple")
        end
    },

    -- Buf management
    {
        'glepnir/flybuf.nvim',
        cmd = 'FlyBuf',
        config = function()
            require('flybuf').setup({})
        end,
    },

    -- Marks
    {
        "chentoast/marks.nvim",
        config = function()
            require('loop.pconf.editor.marks')
        end
    }
}

return editor
