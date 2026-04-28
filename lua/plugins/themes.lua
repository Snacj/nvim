return {
	-- Gruvbox
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
	},
    -- Gruvbox Material
    {
        "sainnhe/gruvbox-material",
        priority = 1000,
    },
	-- Gruber Darker
	{
		"blazkowolf/gruber-darker.nvim",
		priority = 1000,
	},
	-- Monokai (pro)
	{
		"tanvirtin/monokai.nvim",
		priority = 1000,
	},
    -- Coal
    {
    'cranberry-clockworks/coal.nvim',
    },
    -- Rose Pine
    {
        "rose-pine/neovim",
        priority = 1000,
        name = "rose_pine",
        lazy = false,
    },
    -- Bluloco
    {
      'uloco/bluloco.nvim',
      priority = 1000,
      lazy = false,
      dependencies = { 'rktjmp/lush.nvim' },
    },
    -- Dookie
    {
        "pebeto/dookie.nvim",
        priority = 1000,
    },
}
