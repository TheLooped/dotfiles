local coding = {
	-- Lspconfig
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
		},
		config = function()
			require("loop.pconf.lsp")
		end,
	},
	-- Mason
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		build = ":MasonUpdate",
		config = function()
			require("loop.pconf.lsp")
		end,
	},

	-- Auto Completion
	{
		"hrsh7th/nvim-cmp",
		commit = "6c84bc75c64f778e9f1dcb798ed41c7fcb93b639",
		event = "InsertEnter",
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				dependencies = {
					"rafamadriz/friendly-snippets",
				},
			},
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
	},

	-- Misc
	{
		"jinzhongjia/LspUI.nvim",
		branch = "main",
		event = "VeryLazy",
		cmd = "LspUI",
		config = function()
			require("LspUI").setup({
				-- config options go here
			})
		end,
	},
	{
		"stevearc/conform.nvim",
		event = "VeryLazy",
		config = function()
			require("loop.pconf.conform")
		end,
	},
	{
		"weilbith/nvim-code-action-menu",
		lazy = true,
		cmd = "CodeActionMenu",
	},
	{
		"VidocqH/lsp-lens.nvim",
		event = "VeryLazy",
		config = function()
			require("lsp-lens").setup()
		end,
	},
	{
		"Jint-lzxy/lsp_signature.nvim",
		event = "VeryLazy",
	},
}

return coding
