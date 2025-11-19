return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		config = function()
			require("lualine").setup({
				options = {
					--theme = "gruvbox_dark",
					--theme = 'onedark',
					theme = "16color",
				},
			})
		end,
	},
}
