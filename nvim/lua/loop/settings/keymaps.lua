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
            vim.keymap.set(mode, lhs, rhs, options)
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
        local fname = vim.fn.input("FileName:")

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
map('n', '<leader>fn', newFile(), { desc = "New File" })

-- Misc
map('n', '<C-c>', '<cmd>edit ~/.config/nvim<cr>', { desc = "Go to config" })
map('n', '<C-s>', '<cmd>w<cr>', { desc = "Save file" })
map('i', '<leader>j', '<Esc>', { desc = 'Exit Insert' })
map('n', 'J', 'mzJ`z', { desc = "Better line joining" })
map('n', '<C-d>', '<C-d>zz', { desc = "Better Downwards navigation" })
map('n', '<C-u>', '<C-u>zz', { desc = "Better Upwards navigation" })
map('n', 'N', 'Nzzzv', { desc = "Centered search" })
map('n', 'n', 'nzzzv', { desc = "Centered search" })

-- Plugin related

-- FlyBuf
map('n', '<leader>b', '<cmd>FlyBuf<cr>', { desc = "FlyBuf" })
-- Grapple
map('n', '<leader>g', '<cmd>GrapplePopup tags<cr>', { desc = "Grapple" })
map('n', '<leader>gt', '<cmd>GrappleToggle<cr>', { desc = "Grapple" })
map('n', '<leader>gr', '<cmd>GrappleReset<cr>', { desc = "Grapple" })
-- Lazy
map('n', '<leader>l', '<cmd>Lazy<cr>', { desc = "Lazy" })
map('n', '<leader>lu', '<cmd>Lazy update<cr>', { desc = "LazyUpdate" })
map('n', '<leader>ls', '<cmd>Lazy sync<cr>', { desc = "LazySync" })
-- Lazygit
map('n', '<leader>lg', '<cmd>LazyGit<cr>', { desc = "Lazygit" })
-- LspUI
map('n', '<leader>la', '<cmd>LspUI code_action<cr>', { desc = "LspUI code_action" })
map('n', '<leader>lc', '<cmd>LspUI declaration<cr>', { desc = "LspUI declaration" })
map('n', '<leader>ld', '<cmd>LspUI definition<cr>', { desc = "LspUI definition" })
map('n', '<leader>le', '<cmd>LspUI diagnostic<cr>', { desc = "LspUI diagnostic" })
map('n', '<leader>lh', '<cmd>LspUI hover<cr>', { desc = "LspUI hover" })
map('n', '<leader>li', '<cmd>LspUI implementation<cr>', { desc = "LspUI implementation" })
map('n', '<leader>ln', '<cmd>LspUI rename<cr>', { desc = "LspUI rename" })
map('n', '<leader>lr', '<cmd>LspUI reference<cr>', { desc = "LspUI reference" })
map('n', '<leader>lt', '<cmd>LspUI type_definition<cr>', { desc = "LspUI type_definition" })
-- Marks

-- Muren
map('n', '<leader>mt', '<cmd>MurenToggle<cr>', { desc = "Muren Toggle" })
map('n', '<leader>mf', '<cmd>MurenFresh<cr>', { desc = "Fresh Muren instance" })
-- Neotree
map('n', '<leader>n', '<cmd>Neotree toggle<cr>', { desc = "Open Neotree" })
-- Noice
local vim = vim
vim.keymap.set('c', '<S-Enter>', function() require("noice").redirect(vim.fn.getcmdline()) end,
    { desc = 'Redirect Cmdline' })
vim.keymap.set('n', '<leader>snl', function() require("noice").cmd("last") end, { desc = "Noice Last Message" })
vim.keymap.set('n', '<leader>snh', function() require("noice").cmd("history") end, { desc = "Noice History" })
vim.keymap.set('n', '<leader>sna', function() require("noice").cmd("all") end, { desc = "Noice All" })
vim.keymap.set('n', '<leader>snd', function() require("noice").cmd("dismiss") end, { desc = "Dismiss All" })
-- Themery
map('n', '<leader>t', '<cmd>Telescope themes<cr>', { desc = "Themes" })
-- Toggleterm
