local editor = {
	-- File Explorer
	{
		"nvim-neo-tree/neo-tree.nvim",
		cmd = "Neotree",
		branch = "v3.x",
		keys = {
			{
				"<leader>n",
				function()
					require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
				end,
			},
			desc = "Explorer NeoTree",
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
	},

	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
			{ "nvim-lua/plenary.nvim" },
		},
	},

	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = "BufReadPost",
		dependencies = {
			{
				"nvim-treesitter/nvim-treesitter-textobjects",
			},
			{
				"abecodes/tabout.nvim",
				config = function()
					require("loop.pconf.tabout")
				end,
			},
			{
				"Wansmer/treesj",
				keys = { "<space>m", "<space>j", "<space>s" },
				dependencies = { "nvim-treesitter/nvim-treesitter" },
				config = function()
					require("treesj").setup({--[[ your config ]]
					})
				end,
			},
		},
		config = function()
			require("loop.pconf.treesitter")
		end,
	},

	-- Search And Replace
	{
		"AckslD/muren.nvim",
		event = "VeryLazy",
		cmd = {
			"MurenToggle",
			"MurenOpen",
			"MurenClose",
			"MurenUnique",
			"MurenFresh",
		},
		opts = {},
	},

	-- Comments
	{
		"numToStr/Comment.nvim",
		event = "VeryLazy",
		opts = {},
	},
	-- Pairs
	{
		"echasnovski/mini.pairs",
		event = "VeryLazy",
		opts = {},
	},
	-- Surround
	{
		"kylechui/nvim-surround",
		event = "VeryLazy",
		opts = {},
	},

	-- Peeking
	{
		"nacro90/numb.nvim",
		event = "VeryLazy",
		opts = {},
	},
	-- Grapple
	{
		"cbochs/grapple.nvim",
		event = "VeryLazy",
		opts = {},
	},

	-- Buf management
	{
		"glepnir/flybuf.nvim",
		cmd = "FlyBuf",
		opts = {},
	},

	-- Marks
	{
		"chentoast/marks.nvim",
		event = "VeryLazy",
		opts = {},
	},
}

return editor
