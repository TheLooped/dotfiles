require("grapple").setup({
    log_level = "warn",

    scope = "git",

    popup_options = {
        relative = "editor",
        width = 60,
        height = 12,
        style = "minimal",
        focusable = false,
        border = "single",
    },

    integrations = {
        resession = false,
    },
})
