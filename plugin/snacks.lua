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
})

Map("n", "<leader>gg", Snacks.lazygit.open, { desc = "Lazygit Snacks Integration" })

vim.api.nvim_create_autocmd("User", {
	pattern = "OilActionsPost",
	callback = function(event)
		if event.data.actions[1].type == "move" then
			Snacks.rename.on_rename_file(event.data.actions[1].src_url, event.data.actions[1].dest_url)
		end
	end,
})
