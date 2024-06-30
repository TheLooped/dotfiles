local colors = {
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    {
        "savq/melange-nvim",
        priority = 1000,
    },
    {
        "kvrohit/mellow.nvim",
        priority = 1000,
    },
    {
        "TheLooped/cosmos",
        version = "dev",
        priority = 1000
    },
    {
        "dasupradyumna/midnight.nvim",
        priority = 1000,
    },
    {
        "alexmozaidze/palenight.nvim",
        priority = 1000,
    },
    {
        "tiagovla/tokyodark.nvim",
        priority = 1000,
    },
    {
        "folke/tokyonight.nvim",
        priority = 1000,
        opts = { style = "moon" },
    },
    {
        "lunacookies/vim-substrata",
        priority = 1000,
    },
    {
        "zaldih/themery.nvim",
        cmd = "Themery",
        config = function()
            require("themery").setup({
                themes = {
                    "catppuccin",
                    "cosmos",
                    "melange",
                    "mellow",
                    "midnight",
                    "palenight",
                    "substrata",
                    "tokyodark",
                    "tokyonight",
                },
                live_preview = true,
            })
        end,
    },
    {
        'NvChad/nvim-colorizer.lua',
        ft = { 'css', 'html', 'javascript', 'typescript', 'scss' },
        cmd = { 'ColorizerToggle', "ColorizerAttachToBuffer", "ColorizerDetachFromBuffer", "ColorizerReloadAllBuffers" },
        config = function()
            require("colorizer").setup {
                filetypes = { "*" },
                user_default_options = {
                    mode = "background",                            -- Set the display mode.
                    sass = { enable = true, parsers = { "css" }, }, -- Enable sass colors
                    virtualtext = "■",
                    always_update = true
                },
                -- all the sub-options of filetypes apply to buftypes
                buftypes = {},
            }
        end
    }
}

return colors
