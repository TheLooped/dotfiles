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
}

return coding
