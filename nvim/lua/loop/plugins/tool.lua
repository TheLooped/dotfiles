local tool = {
 {
        "kdheepak/lazygit.nvim",
        -- optional for floating window border decoration
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    },
    {
        'ThePrimeagen/vim-be-good'
    },
    {
        'akinsho/toggleterm.nvim',
        version = "*",
        config = true,
    },

}

return tool
