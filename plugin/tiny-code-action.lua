Pack({ "https://github.com/rachartier/tiny-code-action.nvim" })

require("lze").load({
    name = "tiny-code-action",
	event = "LspAttach",
	after = function()
		require("tiny-code-action").setup({
			picker = "snacks",
		})
		Map({ "n", "x" }, "<leader>ca", function()
			require("tiny-code-action").code_action({})
		end, {
        desc = "Show Code Actions"
    })
	end,
})
