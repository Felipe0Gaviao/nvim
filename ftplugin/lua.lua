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
local timer = vim.uv.new_timer()
vim.api.nvim_create_autocmd("PackChanged", {
	callback = function()
		timer = timer or vim.uv.new_timer()
		timer:stop()
		timer:start(
			10000,
			0,
			vim.schedule_wrap(function()
				local config = vim.fn.stdpath("config")
				local result = vim.system({
					"git",
					"-C",
					config,
					"add",
					"nvim-pack-lock.json",
				}, { text = true }):wait()

				if result.code ~= 0 then
					vim.notify("lockfile stage failed:\n" .. result.stderr, vim.log.levels.ERROR)
					return
				end

				result = vim.system({
					"git",
					"-C",
					config,
					"commit",
					"-m",
					"chore(plugins): update lockfile",
				}, { text = true }):wait()

				if result.code ~= 0 then
					local output = (result.stdout or "") .. (result.stderr or "")
					if not output:find("nothing to commit") then
						vim.notify("lockfile commit failed:\n" .. result.stderr, vim.log.levels.ERROR)
					end
				end
			end)
		)
	end,
})

vim.api.nvim_create_user_command("PackClean", function()
	local orphans = {}
	for _, plugin in ipairs(vim.pack.get()) do
		if not plugin.active then
			table.insert(orphans, plugin.spec.name)
		end
	end

	if #orphans == 0 then
		vim.notify("No orphaned plugins found.", vim.log.levels.INFO)
		return
	end

	vim.pack.del(orphans)
	vim.notify("Deleted: " .. table.concat(orphans, ", "), vim.log.levels.WARN)
end, { desc = "Remove plugins installed but not declared in config" })
