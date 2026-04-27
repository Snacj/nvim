local theme = require("ui.theme")

theme.load_last()

if not theme.get() then
	theme.load("gruvbox")
end

vim.api.nvim_create_user_command("Theme", function(opts)
	local name = vim.trim(opts.args)
	theme.load(name)
end, {
	nargs = 1,
	complete = function()
		return {
			"gruvbox",
			"gruvbox_light",
            "gruvbox_material",
			"gruber_darker",
			"monokai",
			"hard_contrast",
			"coal",
			"rose_pine",
            "bluloco",
            "dookie",
		}
	end,
})
