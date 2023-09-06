local config = {
    {
        -- char = "▏",
        char = "│",
        filetype_exclude = {
            "help",
            "alpha",
            "dashboard",
            "neo-tree",
            "Trouble",
            "lazy",
            "mason",
            "notify",
            "toggleterm",
            "themery",
            "lazyterm",
        },
        show_trailing_blankline_indent = false,
        show_current_context = false,
    }
}

require("indent_blankline").setup(config)
