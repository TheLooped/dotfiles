local lsp = {

    --  nvim-lspconfig [lsp configs]
    --  https://github.com/neovim/nvim-lspconfig
    --  This plugin provide default configs for the lsp servers available on mason.
    {
        "neovim/nvim-lspconfig",
        event = "User BaseFile",
        cmds = {
            "LspInfo",
            "LspInstall",
            "LspUninstall",
        }
    },

    -- mason-lspconfig [auto start lsp]
    -- https://github.com/williamboman/mason-lspconfig.nvim
    -- This plugin auto starts the lsp servers installed by Mason
    -- every time Neovim trigger the event FileType.
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "neovim/nvim-lspconfig" },
        event = "User BaseFile",
        opts = function(_, opts)
            local utils_lsp = require("util.lsp")
            if not opts.handlers then opts.handlers = {} end
            opts.handlers[1] = function(server) utils_lsp.setup(server) end

            -- Set the default servers to ensure installed
            opts.ensure_installed = { "v_analyzer", "purescriptls", "lua_ls" }
        end,
        config = function(_, opts)
            local utils_lsp = require("util.lsp")
            local utils = require("util.cmds")

            require("mason-lspconfig").setup(opts)
            utils_lsp.apply_default_lsp_settings() -- Apply our default lsp settings.
            utils.trigger_event("FileType")        -- This line starts this plugin.
        end,
    },

    --  mason [lsp package manager]
    --  https://github.com/williamboman/mason.nvim
    --  https://github.com/Zeioth/mason-extra-cmds
    {
        "williamboman/mason.nvim",
        dependencies = { "Zeioth/mason-extra-cmds", opts = {} },
        cmd = {
            "Mason",
            "MasonInstall",
            "MasonUninstall",
            "MasonUninstallAll",
            "MasonLog",
            "MasonUpdate",
            "MasonUpdateAll", -- this cmd is provided by mason-extra-cmds
        },
        opts = {
            registries = {
                "github:mason-org/mason-registry",
            },
            ui = {
                icons = {
                    package_installed = "✓",
                    package_uninstalled = "✗",
                    package_pending = "⟳",
                },
            },
        }
    },

    --  neodev.nvim [lsp for nvim lua api]
    --  https://github.com/folke/neodev.nvim
    {
        "folke/neodev.nvim",
        opts = {},
        config = function(_, opts)
            require("neodev").setup(opts)
        end,
    },

    --  AUTO COMPLETION --------------------------------------------------------
    --  Auto completion engine [autocompletion engine]
    --  https://github.com/hrsh7th/nvim-cmp
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lsp",
        },
        event = "InsertEnter",
        opts = function()
            local cmp = require("cmp")
            local snip_status_ok, luasnip = pcall(require, "luasnip")
            local lspkind_status_ok, lspkind = pcall(require, "lspkind")
            if not snip_status_ok then
                return
            end
            local border_opts = {
                border = "rounded",
                winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
                scrollbar = false,
            }

            local function has_words_before()
                local line, col = (unpack or table.unpack)(vim.api.nvim_win_get_cursor(0))
                return col ~= 0
                    and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
            end

            local utils = require("util.cmds")
            return {
                enabled = function()
                    local context = require("cmp.config.context")
                    if vim.api.nvim_get_mode().mode == "c" then
                        return true
                    else
                        return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
                    end
                end,

                preselect = cmp.PreselectMode.None,
                formatting = {
                    fields = { "kind", "abbr", "menu" },
                    format = lspkind_status_ok and lspkind.cmp_format(utils.plugin_opts("lspkind.nvim")) or nil,
                },
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                duplicates = {
                    nvim_lsp = 1,
                    luasnip = 1,
                    buffer = 1,
                    path = 1,
                },
                confirm_opts = {
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = false,
                },
                window = {
                    completion = cmp.config.window.bordered(border_opts),
                    documentation = cmp.config.window.bordered(border_opts),
                },
                mapping = {
                    ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                    ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                    ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
                    ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
                    ["<S-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
                    ["<C-y>"] = cmp.config.disable,
                    ["<C-e>"] = cmp.mapping({
                        i = cmp.mapping.abort(),
                        c = cmp.mapping.close(),
                    }),
                    ["<CR>"] = cmp.mapping.confirm({ select = false }),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                },
                sources = cmp.config.sources({
                    { name = "nvim_lsp", priority = 1000 },
                    { name = "luasnip",  priority = 750 },
                    { name = "buffer",   priority = 500 },
                    { name = "path",     priority = 250 },
                }),
                view = {
                    entries = { name = "custom" },
                },
                experimental = {
                    ghost_text = { hlgroup = "Comment" },
                    native = false,
                },
            }
        end,
    },

    {
        "stevearc/conform.nvim",
        event = "User BaseFile",
        opts = {
            formatters_by_ft = {
                c = { "clang_format" },

                javascript = { "biome" },

                lua = { "stylua" },

                ocaml = { "ocamlformat" },

                purescript = { "purs-tidy" },
                python = { "black" },

                zig = { "zigfmt" },
            },
            format_on_save = {
                timeout_ms = 500,
                lsp_fallback = true,
            },
        },
    },

    {
        "jinzhongjia/LspUI.nvim",
        branch = "main",
        event = "VeryLazy",
        cmd = "LspUI",
        config = function()
            require("LspUI").setup({
                lightbulb = {
                    enable = false,
                },
            })
        end,
    },
    -- lsp_signature.nvim [auto params help]
    {
        "ray-x/lsp_signature.nvim",
        event = "User BaseFile",
        opts = function()
            -- Apply globals from 1-options.lua
            local is_enabled = vim.g.lsp_signature_enabled
            local round_borders = {}
            if vim.g.lsp_round_borders_enabled then
                round_borders = { border = "rounded" }
            end
            return {
                -- Window mode
                floating_window = is_enabled, -- Dislay it as floating window.
                hi_parameter = "IncSearch",   -- Color to highlight floating window.
                handler_opts = round_borders, -- Window style

                -- Hint mode
                hint_enable = false, -- Display it as hint.
            }
        end,
        config = function(_, opts)
            require("lsp_signature").setup(opts)
        end,
    },

    {
        "Exafunction/codeium.vim",
        event = "User BaseDefered",

        config = function()
            vim.keymap.set("i", "<A-Tab>", function()
                return vim.fn["codeium#Accept"]()
            end, { expr = true })
            vim.keymap.set("i", "<A-;>", function()
                return vim.fn["codeium#CycleCompletions"](1)
            end, { expr = true })
            vim.keymap.set("i", "<A-,>", function()
                return vim.fn["codeium#CycleCompletions"](-1)
            end, { expr = true })
            vim.keymap.set("i", "<A-x>", function()
                return vim.fn["codeium#Clear"]()
            end, { expr = true })
        end,
    },
}
return lsp
