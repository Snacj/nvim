return {
    name = "gruvbox",
    colorscheme = "gruvbox",
    lualine = "gruvbox",
    setup = function ()
        require("gruvbox").setup({
            contrast = "hard",
        })
    end,
}
