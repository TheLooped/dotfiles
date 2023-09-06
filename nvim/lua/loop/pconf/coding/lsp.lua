local vim = vim

local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

local lsp_attach = function(client, bufnr)
    -- Create your keybindings here...

    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set("n", "<space>ce", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "<space>]", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "<space>[", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "<space>cc", vim.lsp.buf.declaration, bufopts)
    vim.keymap.set("n", "<space>cd", vim.lsp.buf.definition, bufopts)
    vim.keymap.set("n", "<space>ch", vim.lsp.buf.hover, bufopts)
    vim.keymap.set("n", "<space>ci", vim.lsp.buf.implementation, bufopts)
    vim.keymap.set("n", "<space>ct", vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set("n", "<space>cn", vim.lsp.buf.rename, bufopts)
    vim.keymap.set("n", "<space>ca", "<cmd> CodeActionMenu <cr>", bufopts)
    vim.keymap.set("n", "<space>cr", vim.lsp.buf.references, bufopts)
end

local lspconfig = require("lspconfig")

local servers = require("mason-lspconfig").get_installed_servers

for _, server in ipairs(servers()) do
    lspconfig[server].setup({
        on_attach = lsp_attach,
        capabilities = lsp_capabilities,
    })
end

-- Pretty Stuff
vim.diagnostic.config({
    underline = true,
    update_in_insert = false,
    virtual_text = {
        spacing = 4,
        source = "if_many",
        prefix = "●",
    },
    severity_sort = true,
})

local signs = {
    Error = " ",
    Warn = " ",
    Info = " ",
    Hint = " ",
}

for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
