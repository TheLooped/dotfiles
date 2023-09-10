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
		lazy = true,
		priority = 1000,
	},
	{
		"dasupradyumna/midnight.nvim",
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme midnight]])
		end,
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
		event = { "BufNewFile", "BufReadPost" },
		config = function()
			require("loop.pconf.cursorline")
		end,
	},
	-- Cursor word
	{ "echasnovski/mini.cursorword", version = false },
	--Bufferline
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		config = function()
			require("loop.pconf.bufferline")
		end,
	},

	--Lualine
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		config = function()
			require("loop.pconf.lualine")
		end,
	},

	-- Indents

	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("loop.pconf.indentblank")
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
		opts = {
			lsp = {
				override = {
					-- override the default lsp markdown formatter with Noice
					["vim.lsp.util.convert_input_to_markdown_lines"] = false,
					-- override the lsp markdown formatter with Noice
					["vim.lsp.util.stylize_markdown"] = false,
					-- override cmp documentation with Noice (needs the other options to work)
					["cmp.entry.get_documentation"] = false,
				},
				signature = {
					enabled = false,
				},
			},
			routes = {
				{
					filter = {
						event = "msg_show",
						any = {
							{ find = "%d+L, %d+B" },
							{ find = "; after #%d+" },
							{ find = "; before #%d+" },
						},
					},
					view = "mini",
				},
			},
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
				inc_rename = true,
			},
		},
	},
	-- Notify
	{
		"rcarriga/nvim-notify",
		keys = {
			{
				"<leader>un",
				function()
					require("notify").dismiss({ silent = true, pending = true })
				end,
				desc = "Dismiss all Notifications",
			},
		},
		opts = {
			timeout = 3000,
			max_height = function()
				return math.floor(vim.o.lines * 0.75)
			end,
			max_width = function()
				return math.floor(vim.o.columns * 0.75)
			end,
		},
	},
	-- Dressing
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

return ui
