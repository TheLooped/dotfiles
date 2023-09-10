local vim = vim

require("mason").setup()

require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
	},
})

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

-- Server confs

lspconfig.lua_ls.setup({
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})

lspconfig.zls.setup({
	on_aattach = lsp_attach,
	capabilities = lsp_capabilities,
	cmd = { "zls" },
	filetype = { "zig", "zir" },
})

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

local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()

local ok, lspkind = pcall(require, "lspkind")
if not ok then
	return
end

local cmp = require("cmp")

local border = function(hl)
	return {
		{ "╭", hl },
		{ "─", hl },
		{ "╮", hl },
		{ "│", hl },
		{ "╯", hl },
		{ "─", hl },
		{ "╰", hl },
		{ "│", hl },
	}
end
local compare = require("cmp.config.compare")
local comparators = {
	compare.exact,
	compare.sort_text,
	compare.score,
	compare.recently_used,
	require("cmp-under-comparator").under,
	compare.kind,
	compare.length,
	compare.order,
}

cmp.setup({
	enabled = function()
		local context = require("cmp.config.context")
		if vim.api.nvim_get_mode().mode == "c" then
			return true
		else
			return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
		end
	end,
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
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
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif require("luasnip").expand_or_jumpable() then
				vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	sources = {
		{ name = "nvim_lsp", Keyword_length = 2 },
		{ name = "nvim_lua", Keyword_length = 2 },
		{ name = "luasnip", Keyword_length = 2 },
		{ name = "buffer", Keyword_length = 2 },
		{ name = "path" },
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
			"abbr",
			"menu",
			"kind",
		},
		format = lspkind.cmp_format({
			mode = "symbol_text",
			menu = {
				codeium = "",
				nvim_lsp = "λ",
				luasnip = "⋗",
				buffer = "Ω",
			},
			maxwidth = 50,
			ellipsis_char = "...",
			symbol_map = {
				Codeium = "✴",
			},
		}),
	},
	view = {
		entries = { name = "custom" },
	},
	experimental = {
		ghost_text = { hlgroup = "Comment" },
		native = false,
	},
})
