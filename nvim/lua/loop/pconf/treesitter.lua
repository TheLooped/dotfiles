local config = {
    ensure_installed = {
        'bash',
        'c',
        'javascript',
        'json',
        'lua',
        'luadoc',
        'markdown',
        'norg',
        'python',
        'rust',
        'toml',
        'v',
        'vim',
        'vimdoc',
        'yaml',
        'zig'
    },

    sync_install = false,

    auto_install = true,

    context_commentstring = {
        enable = true
    },
    textobjects = {
        lsp_interop = {
            enable = true,
        }
    },
    indent = {
        enable = true
    },
	highlight = {
		enable = true
	}
}
require('nvim-treesitter.configs').setup(config)

