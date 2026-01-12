local api = vim.api
local fn = vim.fn

local SESSION_PATH = fn.stdpath("state") .. "/Session.vim"

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

		-- Write session
		vim.cmd("silent! mksession! " .. SESSION_PATH)

		-- Restart and restore session
		vim.cmd("restart source " .. SESSION_PATH)
	end,
})
