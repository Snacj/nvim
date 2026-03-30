local theme = require("ui.theme")

theme.load_last()

if not theme.get() then
	theme.load("gruvbox")
end

vim.api.nvim_create_user_command("Theme", function(opts)
	theme.load(opts.args)
end, {
	nargs = 1,
	complete = function()
		return {
			"gruvbox",
			"gruber_darker",
            "monokai",
			"hard_contrast",
            "coal",
            "gruvbox_light",
		}
	end,
})
