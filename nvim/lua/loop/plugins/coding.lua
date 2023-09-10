local coding = {
	-- Lspconfig
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
			{
				"Jint-lzxy/lsp_signature.nvim",
				config = require("loop.pconf.coding.sign"),
			},
		},
		config = function()
			require("loop.pconf.coding.lsp")
		end,
	},
	-- Mason
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		build = ":MasonUpdate",
		config = function()
			require("loop.pconf.coding.mason")
		end,
	},

	-- Snippets
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
	},
	-- Auto Completion
	{
		"hrsh7th/nvim-cmp",
		commit = "6c84bc75c64f778e9f1dcb798ed41c7fcb93b639",
		event = "InsertEnter",
		dependencies = {
			{
				"hrsh7th/cmp-nvim-lsp",
			},
			{
				"hrsh7th/cmp-buffer",
			},
			{
				"hrsh7th/cmp-path",
			},
			{
				"saadparwaiz1/cmp_luasnip",
			},
			{
				"lukas-reineke/cmp-under-comparator",
			},
			{
				"onsails/lspkind.nvim",
			},
		},
		config = function()
			require("loop.pconf.coding.cmp")
		end,
	},

	--  Ui
	{
		"jinzhongjia/LspUI.nvim",
		branch = "main",
		event = "LspAttach",
	},
	{
		"Exafunction/codeium.vim",
	},
	-- Formatter
	{
		"stevearc/conform.nvim",
		config = function()
			require("loop.pconf.coding.conform")
		end,
	},
}

return coding
