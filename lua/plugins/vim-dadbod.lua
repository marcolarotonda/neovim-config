return {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
        { "tpope/vim-dadbod",                     lazy = true },
        { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true }, -- Optional
    },
    cmd = {
        "DBUI",
        "DBUIToggle",
        "DBUIAddConnection",
        "DBUIFindBuffer",
    },
    init = function()
        -- Your DBUI configuration
        vim.g.db_ui_use_nerd_fonts = 1
        vim.g.dbs = {
            { name = "dnd5e_test", url = "mysql://root:password@127.0.0.1:3306/dnd5e" },
            { name = "dnd5e",      url = "mysql://admin:marcopasswd@127.0.0.1:3307/dnd5e" },
        }
        vim.g.db_ui_save_location = "~/.config/nvim/db_ui"
    end,
}
