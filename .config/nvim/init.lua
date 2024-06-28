-- Source config files
for _, source in ipairs {
    "core.options",
    "core.keymaps",
    "core.globals",
    "util.lazy",
    "util.autocmds",
} do
    local status_ok, fault = pcall(require, source)
    if not status_ok then
        vim.api.nvim_err_writeln("Failed to load " .. source .. "\n\n" .. fault)
    end
end

local g = require("core.globals")

if g.colorscheme then
    if not pcall(vim.cmd.colorscheme, g.colorscheme) then
        require("util.cmd").notify(
            "Error setting up colorscheme: " .. g.colorscheme,
            vim.log.levels.ERROR
        )
    end
end

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.jule = {
    install_info = {
        url = "~/Lab/Projects/tree-sitter/tree-sitter-jule", -- local path or git repo
        files = { "src/parser.c" },                          -- note that some parsers also require src/scanner.c or src/scanner.cc
        branch = "main",                                     -- default branch in case of git repo if different from master
        generate_requires_npm = false,                       -- if stand-alone parser without npm dependencies
        requires_generate_from_grammar = false,              -- if folder contains pre-generated src/parser.c
    },
    filetype = "jule",                                       -- if filetype does not match the parser name
}

vim.treesitter.language.register('jule', 'jule')


local util = require("lspconfig.util")

return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                biome = {
                    root_dir = function(fname)
                        return util.root_pattern("biome.json", "biome.jsonc")(fname)
                            or util.find_package_json_ancestor(fname)
                            or util.find_node_modules_ancestor(fname)
                            or util.find_git_ancestor(fname)
                    end,
                },
            },
        },
    },
}


-- vim: set ts=4 sw=4 et:
