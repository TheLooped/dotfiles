local coding = {
    -- Main

    -- Lsp
    -- Lspconfig
    {
        "neovim/nvim-lspconfig",
        lazy = true,
        event = {"CursorHold", "CursorHoldI", "BufReadPre", "BufNewFile" },
        dependencies = {
            { "mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },
            {
			    "Jint-lzxy/lsp_signature.nvim",
			    config = require("loop.pconf.coding.sign"),
		    },
            {
                "VidocqH/lsp-lens.nvim",
                event = "LspAttach"
            },
        },
        config = function()
           require('loop.pconf.coding.lsp')
        end
    },
    -- Mason
    {
        "williamboman/mason.nvim",
        lazy = true,
        cmd = "Mason",
        build = ":MasonUpdate",
        config = function()
            require('loop.pconf.coding.mason')
        end
    },

    -- Snippets
    {
        "L3MON4D3/LuaSnip",
        build = (not jit.os:find("Windows"))
            and "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build'; make install_jsregexp"
            or nil,
        dependencies = {
            "rafamadriz/friendly-snippets",
            config = function()
                require("luasnip.loaders.from_vscode").lazy_load()
            end,
        },
    },
    -- Auto Completion
    {
        "hrsh7th/nvim-cmp",
        lazy = true,
        commit = "6c84bc75c64f778e9f1dcb798ed41c7fcb93b639",
        event = "InsertEnter",
        dependencies = {
            "L3MON4D3/LuaSnip" ,
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "saadparwaiz1/cmp_luasnip",
            "lukas-reineke/cmp-under-comparator",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "onsails/lspkind.nvim"
        },
        config = function()
            require('loop.pconf.coding.cmp')
        end
    },

    -- Misc 

    --  Ui
    {
        "jinzhongjia/LspUI.nvim",
        branch = "main",
        event = "LspAttach",
        config = function()
            require("LspUI").setup()
        end
    },
        -- Codeium
    {
        "jcdickinson/codeium.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "hrsh7th/nvim-cmp",
        },
        config = function()
            require('codeium').setup({})
        end
    },
    {
        'Exafunction/codeium.vim',
        config = function ()
            -- Change '<C-g>' here to any keycode you like.
            vim.keymap.set('i', '<A-Tab>', function () return vim.fn['codeium#Accept']() end, { expr = true })
            vim.keymap.set('i', '<A-;>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
            vim.keymap.set('i', '<C-x>', function() return vim.fn['codeium#Clear']() end, { expr = true })
        end
    },
    -- Formatter
    {
        "lukas-reineke/lsp-format.nvim",
        config = function ()
            require("lsp-format").setup()
        end
    }
}

return coding
