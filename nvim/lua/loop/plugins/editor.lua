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
			require("loop.pconf.editor.neo-tree")
		end,
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
		build = function()
			if #vim.api.nvim_list_uis() ~= 0 then
				vim.api.nvim_command("TSUpdate")
			end
		end,
		event = "BufReadPost",
		dependencies = {
			{
				"nvim-treesitter/nvim-treesitter-textobjects",
			},
			{
				"abecodes/tabout.nvim",
				config = function()
					require("loop.pconf.editor.tabout")
				end,
			},
		},
	},

	-- Search And Replace
	{
		"AckslD/muren.nvim",
		event = "VeryLazy",
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
	-- Split Join
	{
		"Wansmer/treesj",
		keys = { "<space>j", "<space>s" },
	},

	-- Grapple
	{
		"cbochs/grapple.nvim",
		event = "VeryLazy",
		config = function()
			require("loop.pconf.editor.grapple")
		end,
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
		config = function()
			require("loop.pconf.editor.marks")
		end,
	},
}

return editor
