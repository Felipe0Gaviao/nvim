vim.pack.add({
	{
		src = "https://github.com/rafamadriz/friendly-snippets",
	},
	{
		src = "https://github.com/saghen/blink.cmp",
	},
})

require("blink.cmp").setup({
	fuzzy = {
		implementation = "rust",
	},
	keymap = {
		preset = "default", -- keep default bindings
		-- Accept current completion with Enter
		["<CR>"] = { "accept", "fallback" },
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
})
