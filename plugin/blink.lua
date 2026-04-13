Pack({
	"https://github.com/rafamadriz/friendly-snippets",
	{
		src = "https://github.com/saghen/blink.cmp",
		version = vim.version.range("*"),
	},
})

require("lze").load({
	{
		"blink.cmp",
		event = { "InsertEnter", "CmdlineEnter" },
		after = function()
			require("blink.cmp").setup({
				sources = {
					default = { "lsp", "path", "buffer" },
				},
				fuzzy = {
					implementation = "rust",
					prebuilt_binaries = {
						download = true,
					},
				},
				keymap = {
					preset = "default",
					["<CR>"] = { "fallback" }, -- CR never accepts, always just newline
					["<Tab>"] = { "accept", "fallback" }, -- Tab accepts or falls through
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
						ghost_text = { enabled = true },
					},
				},
			})
		end,
	},
})
