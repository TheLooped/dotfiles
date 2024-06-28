-- Autocmds

local autocmd = vim.api.nvim_create_autocmd
local utils = require("util.cmds")


-- Existing autocmds for file detection
autocmd({ "BufReadPost", "BufNewFile", "BufWritePost" }, {
    desc = "Implements (BaseFile and BaseGitFile) for file detection",
    callback = function(args)
        local empty_buffer = vim.fn.resolve(vim.fn.expand "%") == ""
        local git_repo = utils.cmd(
            { "git", "-C", vim.fn.fnamemodify(vim.fn.resolve(vim.fn.expand "%"), ":p:h"), "rev-parse" }, false)

        -- For any file except empty buffer
        if not (empty_buffer) then
            utils.trigger_event("User BaseFile")

            -- Is the buffer part of a git repo?
            if git_repo then
                utils.trigger_event("User BaseGitFile")
            end
        end
    end,
})

autocmd({ "VimEnter" }, {
    desc = "Nvim user event that triggers a few ms after nvim starts",
    callback = function()
        -- If nvim is opened passing a filename, trigger the event immediately.
        if #vim.fn.argv() >= 1 then
            -- In order to avoid visual glitches.
            utils.trigger_event("User BaseDefered", true)
            utils.trigger_event("BufEnter", true) -- also, initialize tabline_buffers.
        else
            -- Wait some ms before triggering the event.
            vim.defer_fn(function()
                utils.trigger_event("User BaseDefered")
            end, 70)
        end
    end,
})

-- Autocmd for setting filetype
autocmd({ "BufReadPost", "BufNewFile" }, {
    pattern = "*.jule",
    desc = "Set filetype to jule",
    callback = function()
        vim.bo.filetype = "jule"
    end,
})

-- Autocmd for setting up folding
autocmd("FileType", {
    pattern = "jule",
    desc = "Set up folding for jule files",
    callback = function()
        vim.wo.foldmethod = "expr"
        vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
    end,
})