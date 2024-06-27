-- Options

-- TODO: Improve
local opts = {
    -- Backup
    backup = false,                                  -- creates a backup file
    backupdir = vim.fn.stdpath "cache" .. "/backup", -- where backup files are created
    undodir = vim.fn.stdpath "data" .. "/undo",      -- where undo files are created
    undofile = true,                                 -- enable persistent undo
    writebackup = true,                              -- Make a backup before overwriting a file

    -- Behavior
    confirm = true, -- Confirm to save changes before exiting modified buffer
    hidden = true,  -- Enable modified buffers

    -- Clipboard
    clipboard = "unnamedplus", -- allows neovim to access the system clipboard

    -- Encoding
    encoding = "utf-8",     -- the encoding displayed
    fileencoding = "utf-8", -- the encoding written to a file

    -- Folding
    foldenable = true,   -- Enable folding
    foldlevelstart = 99, -- Open all folds by default

    -- Indentation
    autoindent = true,     -- Preserve current indent on new lines
    breakindent = true,    -- Wrap indent to match  line start.
    copyindent = true,     -- Copy the previous indentation on autoindenting.
    expandtab = true,      -- convert tabs to spaces
    smartindent = true,    -- Smart indent
    shiftround = true,     -- Round indent
    shiftwidth = 4,        -- Size of an indent
    preserveindent = true, -- Preserve indent structure as much as possible

    -- Tabs
    tabstop = 2,     -- number of spaces that a <Tab> in the file counts for
    softtabstop = 4, -- Number of spaces that a <Tab> counts for while performing editing operations
    smarttab = true, -- Use shiftwidth and softtabstop to insert or delete whitespace

    -- Wrapping
    wrap = false,    -- Wrap lines
    wrapscan = true, -- Searches wrap around end-of-file

    -- Line Numbers
    number = true,         -- Show line numbers
    relativenumber = true, -- Show relative line numbers

    -- Mouse
    mouse = "a", -- Enable mouse support

    -- Performance
    lazyredraw = true,
    timeoutlen = 500, -- Time in milliseconds to wait for a mapped sequence to complete.
    updatetime = 300, -- faster completion

    -- Scrolling
    scrolloff = 8,     -- Start scrolling when we're 8 lines away from margins
    sidescrolloff = 8, -- Start scrolling horizontally when we're 8 lines away from margins

    -- Searching
    ignorecase = true,      -- Ignore case when searching
    smartcase = true,       -- Ignore case only when using uppercase
    hlsearch = true,        -- Highlight search results
    infercase = true,       -- Infer case for auto completion
    inccommand = "nosplit", -- preview incremental substitute
    incsearch = true,       -- Incremental search

    -- UI/Appearance
    background = "dark",       -- colorschemes that can be light or dark
    cursorline = true,         -- Highlight current line
    -- cursorcolumn = true, -- Highlight current column
    cmdheight = 0,             -- more space in the neovim command line for displaying messages
    conceallevel = 3,          -- so that `` is visible in markdown files
    display = "lastline",      -- Show as much as possible of the last line
    fillchars = { eob = " " }, -- remove the ~ from end of buffer
    laststatus = 3,            -- global statusline
    list = true,               -- Show some invisible characters (tabs...
    pumblend = 0,              -- Popup blend
    pumheight = 12,            -- Maximum number of entries in a popup
    showcmd = false,           -- Show command
    showmode = false,          -- Dont show mode
    showtabline = 2,           -- always show tabs
    signcolumn = "yes",        -- always show the sign column, otherwise it would shift the text each time
    termguicolors = true,      -- True color support

    -- Windows
    splitbelow = true, -- Open new windows below current
    splitright = true, -- Open new windows right of current

    -- Misc
    completeopt = { "menu", "menuone", "noselect", "popup" }, -- Options for insert mode completion.
    shortmess = "aoOTIcF",                                    -- Reduce messages
    startofline = false,                                      -- Do not reset cursor to start of line when moving around
    swapfile = false,                                         -- Don't use swapfile
    virtualedit = "block",                                    -- allow going past end of line in visual block mode
}

if vim.fn.has "nvim-0.10" == 1 then vim.opt.smoothscroll = true end

for opt, value in pairs(opts) do
    vim.opt[opt] = value
end
