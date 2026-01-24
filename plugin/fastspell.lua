Pack({
	{
		src = "https://github.com/lucaSartore/fastspell.nvim",
	},
})

-- AutoCmd for automatic running of the install script
vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local spec = ev.data.spec
		local kind = ev.data.kind

		if spec.name ~= "fastspell.nvim" then
			return
		end

		if kind ~= "install" and kind ~= "update" then
			return
		end

		local install_script = ev.data.path .. "/lua/scripts/install." .. (vim.fn.has("win32") == 1 and "cmd" or "sh")

		vim.notify("Running fastspell install script", vim.log.levels.INFO)

		vim.system({ install_script }, { cwd = ev.data.path }, function(res)
			if res.code ~= 0 then
				vim.schedule(function()
					vim.notify(
						("fastspell install failed (code %d)\n%s"):format(res.code, res.stderr),
						vim.log.levels.ERROR
					)
				end)
			else
				vim.schedule(function()
					vim.notify("fastspell install completed successfully", vim.log.levels.INFO)
				end)
			end
		end)
	end,
})

local fastspell = require("fastspell")

-- Setup with custom cspell configuration
fastspell.setup({
	cspell_json_file_path = vim.fn.stdpath("config") .. "/cspell.json",
	filter_by_buf_type = true,
	diagnostic_severity = vim.diagnostic.severity.INFO,
})

-- Spellcheck current screen lines automatically
vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI", "BufEnter", "WinScrolled" }, {
	callback = function(_)
		local first_line = vim.fn.line("w0") - 1
		local last_line = vim.fn.line("w$")
		fastspell.sendSpellCheckRequest(first_line, last_line)
	end,
})

-- check only current line + neighbors
vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
	callback = function()
		local current_row = vim.api.nvim_win_get_cursor(0)[1]
		fastspell.sendSpellCheckRequest(current_row - 2, current_row + 1)
	end,
})

-- Commands
vim.api.nvim_create_user_command("SpellCheck", function()
	fastspell.sendSpellCheckRequest(0, vim.api.nvim_buf_line_count(0))
end, {})

vim.api.nvim_create_user_command("SpellIgnore", function()
	fastspell.sendSpellCheckRequest(0, 0)
end, {})
