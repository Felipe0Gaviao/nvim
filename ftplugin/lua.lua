local api = vim.api
local fn = vim.fn

-- Auto restart neovim config while preserving session
api.nvim_create_autocmd("BufWritePost", {
	group = api.nvim_create_augroup("LuaConfigRestartHint", { clear = true }),
	pattern = "*.lua",
	callback = function(args)
		local file = fn.fnamemodify(args.file, ":p")
		local config_dir = fn.stdpath("config")

		if not vim.startswith(file, config_dir) then
			return
		end
		-- Save all buffers silently
		vim.cmd("silent! wall")

		-- Restart and restore session
		require("mini.sessions").restart()
	end,
})
