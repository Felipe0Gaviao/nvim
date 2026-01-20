Pack({
	{
		src = "https://github.com/rafamadriz/friendly-snippets",
	},
	{
		src = "https://github.com/saghen/blink.cmp",
		version = vim.version.range("*"),
	},
})

require("blink.cmp").setup({
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},
	fuzzy = {
		implementation = "rust",
		prebuilt_binaries = {
			download = true,
		},
	},
	keymap = {
		preset = "default", -- keep default bindings
		-- Accept current completion with Tab or Enter
		["<tab>"] = { "accept", "fallback" },
		["<cr>"] = { "accept", "fallback" },
	},
	completion = {
		list = {
			selection = {
				preselect = true, -- automatically select first item
			},
		},
		trigger = {
			show_on_insert = true, -- show automatically when entering insert mode
		},
		accept = {
			auto_brackets = {
				enabled = false, -- disable automatic brackets, if it's still happens, it's probably from the lsp, not from blink
			},
		},
		menu = {
			auto_show = true, -- auto show completion menu
		},
		documentation = {
			auto_show = true, -- auto show documentation
			auto_show_delay_ms = 300,
		},
	},
	cmdline = {
		enabled = true,
		keymap = {
			preset = "cmdline",
			["<Right>"] = false,
			["<Left>"] = false,
		},
		completion = {
			list = { selection = { preselect = false } },
			menu = {
				auto_show = function(_)
					return vim.fn.getcmdtype() == ":"
				end,
			},
			ghost_text = { enabled = true },
		},
	},
})
