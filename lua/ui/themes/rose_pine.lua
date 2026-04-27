return {
    name = "rose_pine",
    colorscheme = "rose-pine",
    lualine = "auto",
    setup = function()
        require("rose-pine").setup({
            -- optional config
            variant = "auto",      -- "main", "moon", "dawn", or "auto"
            dark_variant = "main", -- used when background=dark
            styles = {
                italic = true,
                transparency = false,
            },
        })
    end,
}
