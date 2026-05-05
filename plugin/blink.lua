vim.pack.add({ "https://github.com/saghen/blink.lib", "https://github.com/saghen/blink.cmp" })

vim.api.nvim_create_autocmd("PackChanged", {
	---@param ev {data: vim.event.packchanged.data}
	callback = function(ev)
		if not vim.tbl_contains({ "blink.lib", "blink.cmp" }, ev.data.spec.name) then
			return
		end
		if not vim.tbl_contains({ "update", "install" }, ev.data.kind) then
			return
		end
		require("blink.cmp").build()
	end,
})

require("lze").load({
	{
		"blink.cmp",
		event = { "InsertEnter", "CmdlineEnter" },
		after = function()
			require("blink.cmp").setup({
				sources = {
					default = { "lazydev", "lsp", "path", "buffer" },
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
