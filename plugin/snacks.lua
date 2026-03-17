Pack({
	"https://github.com/folke/snacks.nvim",
})

local Snacks = require("snacks")
Snacks.setup({
	bigfile = {
		enabled = true,
	},
	git = {
		enabled = true,
	},
	lazygit = {
		enabled = true,
	},
	rename = {
		enabled = true,
	},
	terminal = {
		enabled = true,
		win = {
			style = "float",
			border = "rounded",
			width = 0.8,
			height = 0.8,
			keys = {
				term_normal = {
					"<esc>",
					function(self)
						self.esc_timer = self.esc_timer or (vim.uv or vim.loop).new_timer()
						if self.esc_timer:is_active() then
							self.esc_timer:stop()
							vim.cmd("stopinsert")
						else
							self.esc_timer:start(200, 0, function() end)
							return "<esc>"
						end
					end,
					mode = "t",
					expr = true,
					desc = "Double escape to normal mode",
				},
			},
		},
	},
})

Map("n", "<leader>gg", Snacks.lazygit.open, { desc = "Lazygit Snacks Integration" })
Map({ "n", "t" }, [[<C-\>]], function()
	Snacks.terminal.toggle()
end)
Map("n", "<leader>t", function()
	Snacks.terminal.toggle()
end)

vim.api.nvim_create_autocmd("User", {
	pattern = "OilActionsPost",
	callback = function(event)
		if event.data.actions[1].type == "move" then
			Snacks.rename.on_rename_file(event.data.actions[1].src_url, event.data.actions[1].dest_url)
		end
	end,
})
