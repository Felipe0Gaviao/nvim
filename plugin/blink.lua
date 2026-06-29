Pack({
	"https://github.com/rafamadriz/friendly-snippets",
	"https://github.com/saghen/blink.lib",
	"https://github.com/saghen/blink.cmp",
})

require("lze").load({
	{
		"blink.cmp",
		event = { "InsertEnter", "CmdlineEnter" },
		after = function()
			local blink = require("blink.cmp")
			blink.build():pwait(60000)
			blink.setup({
				sources = {
					default = { "lazydev", "lsp", "path", "snippets", "buffer" },
					providers = {
						lazydev = {
							name = "LazyDev",
							module = "lazydev.integrations.blink",
							score_offset = 100,
						},
					},
				},
				fuzzy = {
					implementation = "rust",
				},
				keymap = {
					preset = "default",
					["<C-j>"] = { "select_next", "fallback" },
					["<C-k>"] = { "select_prev", "fallback" },
					["<Tab>"] = { "accept", "fallback" },
				},
				completion = {
					list = {
						selection = {
							preselect = true,
						},
					},
					trigger = {
						show_on_insert = true,
					},
					accept = {
						auto_brackets = {
							enabled = true,
							kind_resolution = {
								blocked_filetypes = { "python" },
							},
							semantic_token_resolution = {
								blocked_filetypes = { "python" },
							},
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
					},
				},
			})
		end,
	},
})
