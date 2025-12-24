local function reload()
	for name, _ in pairs(package.loaded) do
		if vim.startswith(name, "keymaps") or vim.startswith(name, "lsp") then
			package.loaded[name] = nil
		end
	end

	dofile(vim.env.MYVIMRC)
	vim.notify("Config reloaded", vim.log.levels.INFO)
	vim.cmd("nohl")
end

local augroup = vim.api.nvim_create_augroup("UserConfigAutoReload", { clear = true })

vim.api.nvim_create_autocmd("BufWritePost", {
	group = augroup,
	pattern = "*.lua",
	callback = function(args)
		local file = vim.fn.fnamemodify(args.file, ":p")
		local config_path = vim.fn.fnamemodify(vim.fn.stdpath("config"), ":p")

		if not vim.startswith(file, config_path) then
			return
		end

		vim.schedule(function()
			local ok, err = pcall(function()
				reload()
			end)

			if not ok then
				vim.notify(err, vim.log.levels.ERROR, { title = "AutoReloadConfig" })
			end
		end)
	end,
	desc = "Auto-reload Neovim config on save",
})
