local db_utils = require("utils.db")
vim.api.nvim_create_user_command(
    "DBSSH",
    function(opts)
        db_utils.create_ssh_tunnel(opts.args)
    end,
    { nargs = 1, desc = "Apre un tunnel SSH per il database specificato" }
)
