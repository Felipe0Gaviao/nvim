local api = vim.api
local fn = vim.fn

-- Auto restart neovim config while preserving session
api.nvim_create_autocmd("BufWritePost", {
	group = api.nvim_create_augroup("LuaConfigRestartHint", { clear = true }),
	pattern = "*.lua",
    ---@param args vim.api.keyset.create_autocmd.callback_args
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

-- Automate nvim-pack-lock.json chore commit
vim.api.nvim_create_autocmd("PackChanged", {
    ---@param ev {data: vim.event.packchanged.data}
	callback = function(ev)
		local name = ev.data.spec.name
		local kind = ev.data.kind
		local msg = string.format("chore(plugins): %s %s", kind, name)
		local config = fn.stdpath("config")

		vim.defer_fn(function()
			local result = vim.system({
				"git",
				"-C",
				config,
				"commit",
				"--only",
				"nvim-pack-lock.json",
				"-m",
				msg,
			}, { text = true }):wait()

			if result.code ~= 0 then
				local output = (result.stdout or "") .. (result.stderr or "")
				if not output:find("nothing to commit") then
					vim.notify("lockfile commit failed:\n" .. result.stderr, vim.log.levels.ERROR)
				end
			end
		end, 500)
	end,
})
