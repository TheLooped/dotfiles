local luasnip = require('luasnip')
require("luasnip.loaders.from_vscode").lazy_load()

local ok, lspkind = pcall(require, "lspkind")
if not ok then return end

local cmp = require('cmp')

local border = function(hl)
	return {
		{ "┌", hl },
		{ "─", hl },
		{ "┐", hl },
		{ "│", hl },
		{ "┘", hl },
		{ "─", hl },
		{ "└", hl },
		{ "│", hl },
	}
end
local compare = require("cmp.config.compare")
local comparators = {
	compare.offset, -- Items closer to cursor will have lower priority
	compare.exact,
	compare.sort_text,
	compare.score,
	compare.recently_used,
	require("cmp-under-comparator").under,
	compare.kind,
	compare.length,
	compare.order,
}

cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-u>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-q>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<S-CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.

        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.jumpable(1) then
                luasnip.jump_or_expand(1)
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),
    sources = {
        { name = "nvim_lsp",               Keyword_length = 2 },
        { name = "nvim_lua",               Keyword_length = 2 },
        { name = "luasnip",                Keyword_length = 2 },
        { name = "buffer",                 Keyword_length = 2 },
        { name = "path" }
    },
    preselect = cmp.PreselectMode.Item,
	window = {
		completion = {
			border = border("PmenuBorder"),
			winhighlight = "Normal:Pmenu,CursorLine:PmenuSel,Search:PmenuSel",
			scrollbar = false,
		},
		documentation = {
			border = border("CmpDocBorder"),
			winhighlight = "Normal:CmpDoc",
		},
	},
	sorting = {
		priority_weight = 2,
		comparators = comparators,
	},
    matching = {
		disallow_partial_fuzzy_matching = false,
	},
	performance = {
		async_budget = 1,
		max_view_entries = 120,
	},
    formatting = {
        fields = {
            'abbr', 'menu', 'kind'
        },
        format = lspkind.cmp_format({
            mode = "symbol_text",
            menu = ({
                codeium = '',
                nvim_lsp = 'λ',
                luasnip = '⋗',
                buffer = 'Ω',
                path = '🖫',
            }),
            maxwidth = 50,
            ellipsis_char = '...',
            symbol_map = {
                Codeium = '✴',
            },
        }),
    },
    view = {
        entries = { name = 'custom' }
    },
    experimental = {
        ghost_text = { hlgroup = "Comment" },
        native = false
    }
}
