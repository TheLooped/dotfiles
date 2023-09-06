require("conform").setup({
    formatters_by_ft = {
        lua = { "stylua" },
        -- Conform will use the first available formatter in the list
        javascript = { "prettier_d", "prettier" },

        python = { "isort" }
    },
    format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
    }
})
