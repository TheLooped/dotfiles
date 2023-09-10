require("conform").setup({
    formatters_by_ft = {
        c = {"clang_format"},

        javascript = { "prettier_d", "prettier" },

        lua = { "stylua" },

        ocaml = {"ocamlformat"},

        python = { "black" },

        zig = {"zigfmt"},
    },
    format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
    }
})

