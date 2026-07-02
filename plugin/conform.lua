Pack({ "https://github.com/stevearc/conform.nvim" })

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = function(bufnr)
			local start = vim.api.nvim_buf_get_name(bufnr)
			local pyproject_path = vim.fs.find({ "pyproject.toml" }, { path = start, upward = true })[1]
			if pyproject_path then
				local lines = vim.fn.readfile(pyproject_path)
				if vim.tbl_contains(lines, "[tool.black]") then
					return { "black" }
				end
			end
			return { "ruff_fix", "ruff_format", "ruff_organize_imports" }
		end,
		javascript = { "prettier" },
		typescript = { "prettier" },
		toml = { "taplo" },
		json = { "prettier" },
		yaml = { "prettier" },
		markdown = { "prettier" },
		rust = { "rustfmt" },
		nim = { "nimpretty" },
	},
	format_on_save = function(bufnr)
		if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
			return
		end
		return { timeout_ms = 500 }
	end,
})

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

vim.api.nvim_create_user_command("FormatDisable", function(args)
	if args.bang then
		-- FormatDisable! will disable formatting just for this buffer
		vim.b.disable_autoformat = true
	else
		vim.g.disable_autoformat = true
	end
end, {
	desc = "Disable autoformat-on-save",
	bang = true,
})
vim.api.nvim_create_user_command("FormatEnable", function()
	vim.b.disable_autoformat = false
	vim.g.disable_autoformat = false
end, {
	desc = "Re-enable autoformat-on-save",
})
