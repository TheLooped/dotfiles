local ui = {
	-- Themes
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = true,
		priority = 1000,
	},
	{
		"savq/melange-nvim",
		priority = 1000,
		lazy = true,
	},
	{
		"kvrohit/mellow.nvim",
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme mellow]])
		end,
	},
	{
		"dasupradyumna/midnight.nvim",
		priority = 1000,
		lazy = true,
	},
	{
		"wilmanbarrios/palenight.nvim",
		lazy = true,
		priority = 1000,
	},
	{
		"folke/tokyonight.nvim",
		lazy = true,
		priority = 1000,
		opts = { style = "moon" },
	},
	{
		"lunacookies/vim-substrata",
		priority = 1000,
		lazy = true,
	},
	{
		"zaldih/themery.nvim",
		event = "VeryLazy",
		cmd = "Themery",
		config = function()
			require("themery").setup({
				themes = {
					"catppuccin",
					"melange",
					"mellow",
					"midnight",
					"palenight",
					"substrata",
					"tokyonight",
				},
				live_preview = true,
			})
		end,
	},

	--Cursorline
	{
		"gen740/SmoothCursor.nvim",
		config = function()
			require("loop.pconf.ui.smoothcursor")
		end,
		event = { "BufEnter", "BufNewFile", "BufReadPost" },
	},
	--Bufferline
	{
		"akinsho/bufferline.nvim",
		config = function()
			require("loop.pconf.ui.bufferline")
		end,
		event = "VeryLazy",
	},

	--Lualine
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			require("loop.pconf.ui.lualine")
		end,
		event = "VeryLazy",
	},

	-- Indents

	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("loop.pconf.ui.indentline")
		end,
	},

	{
		"echasnovski/mini.indentscope",
		event = { "BufReadPre", "BufNewFile" },
		opts = {},
	},

	-- Noice
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		config = function()
			require("loop.pconf.ui.noice")
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
		},
	},
}

return ui
