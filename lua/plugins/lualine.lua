return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
    },
	event = "VeryLazy",
	config = function()
		local theme = require("ui.theme").get()

		require("lualine").setup({
			options = {
                globalstatus = true,
				theme = theme and theme.lualine or "auto",
				section_separators = "",
				component_separators = "",
			},
		})

	end,
}
