-- Configuration
vim.g.mapleader = " "

-- Helper function for mapping
local function map(modes, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend('force', options, opts)
    end

    if type(modes) == 'string' then
        modes = { modes }
    end

    for _, mode in ipairs(modes) do
        if type(rhs) == 'function' then
		local fn_name = string.format("lua %s()", tostring(rhs))
            vim.keymap.set(mode, lhs, fn_name, options)
        else
            vim.api.nvim_set_keymap(mode, lhs, rhs, options)
        end

        if opts and opts.desc then
            options.desc = opts.desc
            vim.keymap.set( mode, lhs, rhs, options)
        end
    end
end

-- Editing Essentials
map({ 'n', 'i' }, '<C-s>', ':w<cr>', { desc = 'Save' })
map({ 'n', 'i' }, '<C-q>', '<cmd>wqa<cr>', { desc = 'Quit and save' })

map({ 'n', 'v' }, '<leader>p', '"+p', { desc = "Paste from system clipboard" })
map({ 'n', 'v' }, '<leader>y', '"+y', { desc = "Copy to system clipboard" })
map('n', '<leader>Y', '"+Y', { desc = "Copy line to system clipboard" })

map({ 'n', 'v' }, 'p', 'p', { desc = "regular paste" })
map({ 'n', 'v' }, 'y', 'y', { desc = "regular paste" })

-- Navigation
-- Better Movement
map('n', 'j', "v:count == 0 ? 'gj' : 'j' ", { expr = true, silent = true, desc = "Better Down" })
map('n', 'k', "v:count == 0 ? 'gk' : 'k' ", { expr = true, silent = true, desc = "Better Up" })

map('n', '<C-d>', '<C-d>zz', { desc = "Better Downwards navigation" })
map('n', '<C-u>', '<C-u>zz', { desc = "Better Upwards navigation" })

--Insert Navigation
map('i', '<C-h>', '<Left>', { desc = "Move Left" })
map('i', '<C-j>', '<Down>', { desc = "Move Upward" })
map('i', '<C-k>', '<Up>', { desc = "Move Downwards" })
map('i', '<C-l>', '<Right>', { desc = "Move Right" })

-- Line Movement
-- Normal
map('n', '<A-j>', '<cmd>m .+1<cr>==', { desc = "Move Line Down" })
map('n', '<A-k>', '<cmd>m .-2<cr>==', { desc = "Move Line Up" })

-- Insert
map('i', '<A-j>', '<cmd>m .+1<cr>==', { desc = "Move Line Down" })
map('i', '<A-k>', '<cmd>m .-2<cr>==', { desc = "Move Line Up" })

-- Visual
map('v', '<A-j>', "<cmd>m '<+1<cr>gv=gv", { desc = "Move Line " })
map('v', '<A-k>', "<cmd>m '<-2<cr>gv=gv", { desc = "Move Line Up" })


-- Tab Movement


-- Buffer & Window Management

-- Windows Management
map('n', '<leader>-', '<cmd>split<cr>', { desc = "Split Horizontal" })
map('n', '<leader>|', '<cmd>vsplit<cr>', { desc = "Split Vertical" })
map('n', '<leader>wd', '<C-w>q', { desc = "Close Window" })

-- Window Navigation
map('n', '<C-h>', '<C-w>h', { desc = "Move to Window Left" })
map('n', '<C-j>', '<C-w>j', { desc = "Move to Window Down" })
map('n', '<C-k>', '<C-w>k', { desc = "Move to Window Up" })
map('n', '<C-l>', '<C-w>l', { desc = "Move to Window Right" })

local function newFile()
    return function()
        local fname = vim.fn.input("File:")

        if fname == '' then
            print('No file name')
            return
        else
            vim.cmd([[enew]])
            vim.api.nvim_buf_set_name(0, fname)
        end
    end
end

-- Buffer Management
map('n', '<leader>bd', '<cmd>bdelete<cr>', { desc = "Delete Buffer" })
map('n', '<leader>fn', newFile(), {desc = "New File"})

-- Misc
map('n', '<C-c>', '<cmd>edit ~/.config/nvim<cr>', { desc = "Go to config" })
map('n', '<C-s>', '<cmd>w<cr>', { desc = "Save file" })
map('i', '<leader>j', '<Esc>', { desc = 'Exit Insert' })
map('n', 'J', 'mzJ`z', { desc = "Better line joining" })
map('n', '<C-d>', '<C-d>zz', { desc = "Better Downwards navigation" })
map('n', '<C-u>', '<C-u>zz', { desc = "Better Upwards navigation" })
map('n', 'N', 'Nzzzv', { desc = "Centered search" })
map('n', 'n', 'nzzzv', { desc = "Centered search" })


