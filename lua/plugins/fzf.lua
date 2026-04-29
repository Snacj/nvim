return {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-mini/mini.icons" },
    opts = {},
    keys = {
        {
            "<leader>ff",
            function() require('fzf-lua').files() end,
            desc = "Find files in project directory",
        },
        {
            "<leader>fg",
            function() require('fzf-lua').live_grep() end,
            desc = "Find by grepping project directory",
        },
        {
            "<leader>fk",
            function() require("fzf-lua").keymaps() end,
            desc = "[F]ind [K]eymaps",
        },
        {
            "<leader>fw",
            function() require("fzf-lua").grep_cword() end,
            desc = "[F]ind current [W]ord",
        },
        {
            "<leader>fW",
            function() require("fzf-lua").grep_cWORD() end,
            desc = "[F]ind current [W]ORD",
        },
        {
            "<leader>fr",
            function() require("fzf-lua").resume() end,
            desc = "[F]ind [R]esume",
        },
        {
            "<leader>fo",
            function() require("fzf-lua").oldfiles() end,
            desc = "[F]ind [O]ld Files",
        },
        {
            "<leader><leader>",
            function() require("fzf-lua").buffers() end,
            desc = "[ ] Find existing buffers",
        },
    }
}
