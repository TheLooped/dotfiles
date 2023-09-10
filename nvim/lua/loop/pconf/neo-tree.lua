local config = {
	sources = {
		"filesystem",
		"buffers",
		"git_status",
		-- "document_symbols",
	},
	default_source = "filesystem",

	enable_diagnostics = true,
	close_if_last_window = true,
	enable_git_status = true,
	enable_modified_markers = true, -- Show markers for files with unsaved changes.
	enable_opened_markers = true, -- Enable tracking of opened files. Required for `components.name.highlight_opened_files`
	enable_refresh_on_write = true, -- Refresh the tree when a file is written. Only used if `use_libuv_file_watcher` is false.
	enable_normal_mode_for_inputs = false, -- Enable normal mode for input dialogs.
	git_status_async = true,
	open_files_in_last_window = true, -- false = open files in top left window
	open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "edgy" }, -- when opening files, do not use windows containing these filetypes or buftypes
	popup_border_style = "rounded", -- "double", "none", "rounded", "shadow", "single" or "solid"
	sort_case_insensitive = false, -- used when sorting files and directories in the tree
	sort_function = nil, -- uses a custom function for sorting files and directories in the tree
	use_popups_for_input = true, -- If false, inputs will use vim.ui.input() instead of custom floats.
	use_default_mappings = true,
	source_selector = {
		winbar = true, -- toggle to show selector on winbar
		show_scrolled_off_parent_node = false, -- this will replace the tabs with the parent path
		sources = {
			{ source = "filesystem" },
			{ source = "git_status" },
		},
		content_layout = "start", -- only with `tabs_layout` = "equal", "focus"
		tabs_layout = "equal", -- start, end, center, equal, focus
		truncation_character = "…", -- character to use when truncating the tab label
		tabs_min_width = nil, -- nil | int: if int padding is added based on `content_layout`
		tabs_max_width = nil, -- this will truncate text even if `text_trunc_to_fit = false`
		padding = 0, -- can be int or table
		-- padding = { left = 2, right = 0 },
		separator = { left = "▏", right = "▕" },
		separator_active = nil, -- set separators around the active tab. nil falls back to `source_selector.separator`
		show_separator_on_edge = false,
		highlight_tab = "NeoTreeTabInactive",
		highlight_tab_active = "NeoTreeTabActive",
		highlight_background = "NeoTreeTabInactive",
		highlight_separator = "NeoTreeTabSeparatorInactive",
		highlight_separator_active = "NeoTreeTabSeparatorActive",
	},
	default_component_configs = {
		container = {
			enable_character_fade = true,
			width = "100%",
			right_padding = 0,
		},
		diagnostics = {
			symbols = {
				hint = "",
				info = "",
				warn = "",
				error = "",
			},
			highlights = {
				hint = "DiagnosticSignHint",
				info = "DiagnosticSignInfo",
				warn = "DiagnosticSignWarn",
				error = "DiagnosticSignError",
			},
		},
		indent = {
			indent_size = 2,
			padding = 1,
			-- indent guides
			with_markers = true,
			indent_marker = "│",
			last_indent_marker = "└",
			highlight = "NeoTreeIndentMarker",
			-- expander config, needed for nesting files
			with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
			expander_collapsed = "",
			expander_expanded = "",
			expander_highlight = "NeoTreeExpander",
		},
		icon = {
			folder_closed = "",
			folder_open = "",
			folder_empty = "󰜌",
			folder_empty_open = "󰜌",
			-- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
			-- then these will never be used.
			default = "*",
			highlight = "NeoTreeFileIcon",
		},
		modified = {
			symbol = "[+] ",
			highlight = "NeoTreeModified",
		},
		name = {
			trailing_slash = false,
			highlight_opened_files = true, -- Requires `enable_opened_markers = true`.
			use_git_status_colors = true,
			highlight = "NeoTreeFileName",
		},
		git_status = {
			symbols = {
				-- Change type
				added = "✚", -- NOTE: you can set any of these to an empty string to not show them
				deleted = "",
				modified = "",
				renamed = "󰁕",
				-- Status type
				untracked = "",
				ignored = "",
				unstaged = "󰄱",
				staged = "",
				conflict = "",
			},
			align = "right",
		},
	},
	window = {
		position = "left", -- left, right, top, bottom, float, current
		width = 40, -- applies to left and right positions
		height = 15, -- applies to top and bottom positions
		mapping_options = {
			noremap = true,
			nowait = true,
		},
		mappings = {
			["<space>"] = "none",
			["<2-LeftMouse>"] = "open",
			["<cr>"] = "open",
			["<esc>"] = "cancel", -- close preview or floating neo-tree window
			["P"] = { "toggle_preview", config = { use_float = true } },
			["l"] = "focus_preview",
			["S"] = "open_split",
			["s"] = "open_vsplit",
			["t"] = "open_tabnew",
			["w"] = "open_with_window_picker",
			["C"] = "close_node",
			["z"] = "close_all_nodes",
			["R"] = "refresh",
			["a"] = {
				"add",
				config = {
					show_path = "none", -- "none", "relative", "absolute"
				},
			},
			["A"] = "add_directory", -- also accepts the config.show_path and config.insert_as options.
			["d"] = "delete",
			["r"] = "rename",
			["y"] = "copy_to_clipboard",
			["x"] = "cut_to_clipboard",
			["p"] = "paste_from_clipboard",
			["c"] = "copy", -- takes text input for destination, also accepts the config.show_path and config.insert_as options
			["m"] = "move", -- takes text input for destination, also accepts the config.show_path and config.insert_as options
			["e"] = "toggle_auto_expand_width",
			["q"] = "close_window",
			["?"] = "show_help",
			["<"] = "prev_source",
			[">"] = "next_source",
		},
	},
	filesystem = {
		window = {
			mappings = {
				["H"] = "toggle_hidden",
				["/"] = "fuzzy_finder",
				["D"] = "fuzzy_finder_directory",
				--["/"] = "filter_as_you_type", -- this was the default until v1.28
				["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
				-- ["D"] = "fuzzy_sorter_directory",
				["f"] = "filter_on_submit",
				["<C-x>"] = "clear_filter",
				["<bs>"] = "navigate_up",
				["."] = "set_root",
				["[g"] = "prev_git_modified",
				["]g"] = "next_git_modified",
			},
			fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
				["<down>"] = "move_cursor_down",
				["<C-n>"] = "move_cursor_down",
				["<up>"] = "move_cursor_up",
				["<C-p>"] = "move_cursor_up",
			},
		},
		async_directory_scan = "auto", -- "auto"   means refreshes are async, but it's synchronous when called from the Neotree commands.
		scan_mode = "shallow", -- "shallow": Don't scan into directories to detect possible empty directory a priori
		bind_to_cwd = true, -- true creates a 2-way binding between vim's cwd and neo-tree's root
		find_by_full_path_words = false, -- `false` means it only searches the tail of a path.
		group_empty_dirs = false, -- when true, empty folders will be grouped together
		search_limit = 50, -- max number of search results when using filters
		follow_current_file = {
			enabled = false, -- This will find and focus the file in the active buffer every time
			leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
		},
		hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
		use_libuv_file_watcher = true, -- This will use the OS level file watchers to detect changes
	},
}

require("neo-tree").setup(config)
