local ui = {
    {
        "MunifTanjim/nui.nvim",
    },

    -- Cursor word
    {
        "echasnovski/mini.cursorword",
        event = { "BufReadPost", "BufNewFile" },
        version = false,
        opts = {},
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
        main = "ibl",
        opts = {
            enabled = true,
            indent = {
                char = "│",
                tab_char = "│",
                smart_indent_cap = true,
                priority = 2,
            },
            whitespace = {
                highlight = { "Whitespace", "NonText" },
                remove_blankline_trail = true,
            },
            exclude = {
                buftypes = {
                    "help",
                    "alpha",
                    "dashboard",
                    "neo-tree",
                    "Trouble",
                    "lazy",
                    "mason",
                    "notify",
                    "toggleterm",
                    "lazyterm",
                },
            },
            scope = {
                enabled = true,
                show_start = true,
                show_end = false,
                injected_languages = true,
                priority = 500,
            },
        },
    },

    --  mini.indentscope [guides]
    --  https://github.com/echasnovski/mini.indentscope
    {
        "echasnovski/mini.indentscope",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            draw = {
                delay = 0,
                animation = function()
                    return 0
                end,
            },
            options = { border = "top", try_as_border = true },
            symbol = "▏",
        },
        config = function(_, opts)
            require("mini.indentscope").setup(opts)

            -- Disable for certain filetypes
            vim.api.nvim_create_autocmd({ "FileType" }, {
                desc = "Disable indentscope for certain filetypes",
                callback = function()
                    local ignored_filetypes = {
                        "aerial",
                        "dashboard",
                        "help",
                        "lazy",
                        "leetcode.nvim",
                        "mason",
                        "neo-tree",
                        "NvimTree",
                        "neogitstatus",
                        "notify",
                        "startify",
                        "toggleterm",
                        "Trouble",
                    }
                    if vim.tbl_contains(ignored_filetypes, vim.bo.filetype) then
                        vim.b.miniindentscope_disable = true
                    end
                end,
            })
        end,
    },

    --  [better ui elements]
    --  https://github.com/stevearc/dressing.nvim
    {
        "stevearc/dressing.nvim",
        event = "User BaseDefered",
        opts = {
            input = { default_prompt = "➤ " },
            select = { backend = { "telescope", "builtin" } },
        }
    },

    -- Notify
    {
        "rcarriga/nvim-notify",
        event = "User BaseDefered",
        init = function()
            require("util.cmds").load_plugin_with_func("nvim-notify", vim, "notify")
        end,
        keys = {
            {
                "<leader>un",
                function()
                    require("notify").dismiss({ silent = true, pending = true })
                end,
                desc = "Dismiss all Notifications",
            },
        },
        opts = function()
            return {
                timeout = 2500,
                max_height = function()
                    return math.floor(vim.o.lines * 0.75)
                end,
                max_width = function()
                    return math.floor(vim.o.columns * 0.75)
                end,
                on_open = function(win)
                    -- enable markdown support on notifications
                    vim.api.nvim_win_set_config(win, { zindex = 175 })

                    if not package.loaded["nvim-treesitter"] then
                        pcall(require, "nvim-treesitter")
                    end

                    vim.wo[win].conceallevel = 3
                    local buf = vim.api.nvim_win_get_buf(win)
                    if not pcall(vim.treesitter.start, buf, "markdown") then
                        vim.bo[buf].syntax = "markdown"
                    end
                    vim.wo[win].spell = false
                end,
            }
        end,
        config = function(_, opts)
            local notify = require("notify")
            notify.setup(opts)
            vim.notify = notify
        end,
    },

    -- Noice.nvim [better cmd/search line]
    {
        "folke/noice.nvim",
        event = "User BaseDefered",
        opts = function()
            local enable_conceal = false -- Hide command text if true
            return {
                presets = {
                    bottom_search = true,
                    command_palette = true,
                }, -- The kind of popup used for /
                routes = {
                    {
                        filter = {
                            event = "msg_show",
                            any = {
                                { find = "%d+L, %d+B" },
                                { find = "; after #%d+" },
                                { find = "; before #%d+" },
                            },
                        },
                        view = "mini",
                    },
                },
                lsp = {
                    hover = { enabled = false },
                    signature = { enabled = false },
                    progress = { enabled = false },
                    message = { enabled = false },
                    smart_move = { enabled = false },
                },
                cmdline = {
                    view = "cmdline", -- The kind of popup used for :
                    format = {
                        cmdline = { conceal = enable_conceal },
                        search_down = { conceal = enable_conceal },
                        search_up = { conceal = enable_conceal },
                        filter = { conceal = enable_conceal },
                        lua = { conceal = enable_conceal },
                        help = { conceal = enable_conceal },
                        input = { conceal = enable_conceal },
                    }
                },
            }
        end,
    },

    --  UI icons [icons]
    --  https://github.com/nvim-tree/nvim-web-devicons
    {
        "nvim-tree/nvim-web-devicons",
        enabled = vim.g.icons_enabled,
        event = "User BaseDefered",
        opts = {
            override = {
                default_icon = {
                    icon = require("util.cmds").get_icon("DefaultFile"),
                    name = "default"
                },
                deb = { icon = "", name = "Deb" },
                lock = { icon = "󰌾", name = "Lock" },
                mp3 = { icon = "󰎆", name = "Mp3" },
                mp4 = { icon = "", name = "Mp4" },
                out = { icon = "", name = "Out" },
                ["robots.txt"] = { icon = "󰚩", name = "Robots" },
                ttf = { icon = "", name = "TrueTypeFont" },
                rpm = { icon = "", name = "Rpm" },
                woff = { icon = "", name = "WebOpenFontFormat" },
                woff2 = { icon = "", name = "WebOpenFontFormat2" },
                xz = { icon = "", name = "Xz" },
                zip = { icon = "", name = "Zip" },
            },
        },
        config = function(_, opts)
            require("nvim-web-devicons").setup(opts)
            pcall(vim.api.nvim_del_user_command, "NvimWebDeviconsHiTest")
        end
    },

    --  LSP icons [icons]
    --  https://github.com/onsails/lspkind.nvim
    {
        "onsails/lspkind.nvim",
        opts = {
            mode = "symbol",
            symbol_map = {
                Array = "󰅪",
                Boolean = "⊨",
                Class = "󰌗",
                Constructor = "",
                Key = "󰌆",
                Namespace = "󰅪",
                Null = "NULL",
                Number = "#",
                Object = "󰀚",
                Package = "󰏗",
                Property = "",
                Reference = "",
                Snippet = "",
                String = "󰀬",
                TypeParameter = "󰊄",
                Unit = "",
            },
            menu = {},
        },
        enabled = vim.g.icons_enabled,
        config = function(_, opts)
            require("lspkind").init(opts)
        end,
    },

    --  Noice.nvim [better cmd/search line]
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = function()
            return {
                presets = {
                    bottom_search = true,
                    command_palette = true,
                }, -- The kind of popup used for /
                routes = {
                    {
                        filter = {
                            event = "msg_show",
                            any = {
                                { find = "%d+L, %d+B" },
                                { find = "; after #%d+" },
                                { find = "; before #%d+" },
                            },
                        },
                        view = "mini",
                    },
                },

                lsp = {
                    hover = { enabled = false },
                    signature = { enabled = false },
                    progress = { enabled = false },
                    --message = { enabled = false },
                    smart_move = { enabled = false },
                },
            }
        end,
    },

    {
        "MunifTanjim/nougat.nvim",
        event = "BufEnter",
        opts = function()
            local Bar = require("nougat.bar")
            local core = require("nougat.core")
            local Item = require("nougat.item")
            local sep = require("nougat.separator")

            local color = {
                -- stylua: ignore
                bg         = "#00000c",
                fg         = "#0d0e00",

                amber      = "#ffd180",
                cyan       = "#84ffff",
                blue       = "#B0D1E8",
                teal       = "#AEE4E7",
                seafoam    = "#9FE7E0",
                mint       = "#8BEED3",
                lime       = "#e6ff80",
                neon_mint  = "#B5FFD8",
                sage       = "#D1E3C7",
                sand       = "#EEE2AF",
                peach      = "#FCD0A0",
                coral      = "#F7B39C",
                salmon     = "#F7A28E",
                rose       = "#F78C8C",
                indigo     = "#7986cb",
                lavender   = "#DCBFE5",
                lilac      = "#C5B1DC",
                periwinkle = "#BAAAD8",
                slate      = "#8B9BB3",
                charcoal   = "#5F727D",
            }
            local nut = {
                buf = {
                    diagnostic_count = require("nougat.nut.buf.diagnostic_count").create,
                    fileencoding = require("nougat.nut.buf.fileencoding").create,
                    fileformat = require("nougat.nut.buf.fileformat").create,
                    filename = require("nougat.nut.buf.filename").create,
                    filestatus = require("nougat.nut.buf.filestatus").create,
                    filetype = require("nougat.nut.buf.filetype").create,
                    wordcount = require("nougat.nut.buf.wordcount").create,
                },
                lsp = {
                    servers = require("nougat.nut.lsp.servers"),
                },
                git = {
                    branch = require("nougat.nut.git.branch").create,
                    status = require("nougat.nut.git.status"),
                },
                tab = {
                    tablist = {
                        tabs = require("nougat.nut.tab.tablist").create,
                        close = require("nougat.nut.tab.tablist.close").create,
                        icon = require("nougat.nut.tab.tablist.icon").create,
                        label = require("nougat.nut.tab.tablist.label").create,
                        modified = require("nougat.nut.tab.tablist.modified").create,
                    },
                },
                mode = require("nougat.nut.mode").create,
                spacer = require("nougat.nut.spacer").create,
                truncation_point = require("nougat.nut.truncation_point").create,
            }

            -- renders space only when item is rendered
            ---@param item NougatItem
            local function paired_space(item)
                return Item({
                    content = sep.space().content,
                    hidden = item,
                })
            end

            local breakpoint = { l = 1, m = 2, s = 3 }
            local breakpoints = { [breakpoint.l] = math.huge, [breakpoint.m] = 128, [breakpoint.s] = 80 }

            local stl = Bar("statusline", { breakpoints = breakpoints })

            local ruler = (function()
                local item = Item({
                    content = {
                        Item({
                            hl = { bg = color.slate, fg = color.bg },
                            content = core.group({
                                core.code("l"),
                                ":",
                                core.code("c"),
                            }, { align = "center", min_width = 5 }),
                            suffix = " ",
                        }),
                    },
                })

                return item
            end)()

            local mode = nut.mode({
                prefix = " ",
                suffix = " ",
                config = {
                    highlight = {
                        normal = {
                            bg = color.amber,
                            fg = "#000007",
                        },
                        visual = {
                            bg = color.rose,
                            fg = color.fg,
                        },
                        insert = {
                            bg = color.blue,
                            fg = color.fg,
                        },
                        replace = {
                            bg = color.indigo,
                            fg = color.fg,
                        },
                        commandline = {
                            bg = color.mint,
                            fg = color.fg,
                        },
                        terminal = {
                            bg = color.neon_mint,
                            fg = color.fg,
                        },
                        inactive = {},
                    },
                },
            })

            local filename = (function()
                local item = Item({
                    prepare = function(_, ctx)
                        local bufnr, data = ctx.bufnr, ctx.ctx
                        data.readonly = vim.api.nvim_buf_get_option(bufnr, "readonly")
                        data.modifiable = vim.api.nvim_buf_get_option(bufnr, "modifiable")
                        data.modified = vim.api.nvim_buf_get_option(bufnr, "modified")
                    end,
                    content = {
                        Item({
                            hl = { fg = color.peach },
                            hidden = function(_, ctx)
                                return not ctx.ctx.readonly
                            end,
                            suffix = " ",
                            content = "󰷭",
                        }),
                        Item({
                            hl = { fg = color.sage },
                            hidden = function(_, ctx)
                                return ctx.ctx.modifiable
                            end,
                            content = " ",
                            suffix = " ",
                        }),
                        nut.buf.filename({
                            hl = { fg = color.salmon },
                            prefix = function(_, ctx)
                                local data = ctx.ctx
                                if data.readonly or not data.modifiable then
                                    return " "
                                end
                                return ""
                            end,
                            suffix = function(_, ctx)
                                local data = ctx.ctx
                                if data.modified then
                                    return " "
                                end
                                return ""
                            end,
                        }),
                        Item({
                            hl = { fg = color.lime },
                            hidden = function(_, ctx)
                                return not ctx.ctx.modified
                            end,
                            prefix = " ",
                            content = " ●",
                        }),
                    },
                })

                return item
            end)()

            local lsp_servers = nut.lsp.servers.create({
                config = {
                    content = function(client, item)
                        return {
                            content = client.name,
                            hl = { fg = color.cyan },
                        }
                    end,
                    sep = " ",
                },
                suffix = " ",
            })

            stl:add_item(mode)
            stl:add_item(nut.git.branch({
                hl = { bg = "#665c54", fg = "#ebdbb2" },
                prefix = { "  ", " " },
                suffix = " ",
            }))
            stl:add_item(sep.space())
            stl:add_item(filename)
            stl:add_item(nut.spacer())
            stl:add_item(lsp_servers)
            stl:add_item(nut.spacer())
            stl:add_item(nut.buf.filetype({
                hl = { fg = color.teal },
            }))
            stl:add_item(sep.space())
            stl:add_item(nut.buf.diagnostic_count({
                prefix = " ",
                suffix = " ",
                config = {
                    error = { prefix = " ", fg = "#FF7C71" },
                    warn = { prefix = " ", fg = "#B2DFAA" },
                    info = { prefix = " ", fg = "#7FBFFF" },
                    hint = { prefix = " ", fg = "#b3ff66" },
                },
            }))
            stl:add_item(ruler)

            return stl
        end,

        config = function(_, opts)
            require("nougat").set_statusline(opts)
        end,
    },
}
return ui
