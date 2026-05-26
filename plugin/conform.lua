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
	format_on_save = {
		timeout_ms = 1000,
	},
})

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
