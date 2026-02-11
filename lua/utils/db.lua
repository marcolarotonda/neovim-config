local get_config_lsp = function(t)
	local concat_table = {
		t.user,
		":",
		t.password,
		"@tcp(",
		t.ip,
		":",
		t.port,
		")/",
		t.schema,
	}
	return table.concat(concat_table)
end

local get_config_dadbod = function(t)
	local cnf_path = string.format("/tmp/.my_cnf_%s", t.db_alias)
	local cnf_content =
		string.format("[client]\nuser=%s\npassword=%s\nhost=%s\nport=%s\n", t.user, t.password, t.ip, t.port)
	local f = io.open(cnf_path, "w")
	f:write(cnf_content)
	f:close()
	vim.fn.system("chmod 600 " .. cnf_path)
	return string.format("mysql:///?defaults-extra-file=%s&database=%s", cnf_path, t.schema)
end

local format_config = function(t)
	return {
		lsp_config = {
			driver = t.driver,
			dataSourceName = get_config_lsp(t),
		},
		dadbod_config = {
			name = t.db_alias,
			url = get_config_dadbod(t),
		},
	}
end

local get_config_list = function(ts)
	local to_return = {}
	to_return.for_dadbod = {}
	to_return.for_lsp = {}
	for index, value in ipairs(ts) do
		local formatted = format_config(value)
		to_return.for_dadbod[index] = formatted.dadbod_config
		to_return.for_lsp[index] = formatted.lsp_config
	end
	return to_return
end

local create_ssh_tunnel = function(db_alias)
	local databases = require("secrets.db")
	for _, value in ipairs(databases) do
		if value.db_alias == db_alias and value.ssh_tunnel then
			local local_port = value.ssh_tunnel.local_port or value.port
			local command = string.format(
				"ssh -f -N -i %s -L %s:%s:%s %s@%s",
				value.ssh_tunnel.path_pem,
				local_port,
				value.ip,
				value.ssh_tunnel.remote_port,
				value.ssh_tunnel.user,
				value.ssh_tunnel.remote_ip
			)
			print(command)
			vim.fn.jobstart(command, {
				on_exit = function(_, exit_code)
					if exit_code == 0 then
						vim.notify("SSH tunnel aperto per " .. db_alias, vim.log.levels.INFO)
					else
						vim.notify("Errore tunnel SSH per " .. db_alias, vim.log.levels.ERROR)
					end
				end,
			})
			return
		end
	end
	vim.notify("Database alias non trovato: " .. db_alias, vim.log.levels.WARN)
end

return {
	get_config_list = get_config_list,
	create_ssh_tunnel = create_ssh_tunnel,
}
