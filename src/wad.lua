local find = function()
	local home = os.getenv('HOME')
	local data_dir = os.getenv('XDG_DATA_HOME') or (home .. '/.local/share')
end

local command_list = {
	find = find
}

local main = function ()
	local cmd = arg[2]

	local func = command_list[cmd]

	if (func ~= nil) then
		func()
	else
		io.stderr('Command not found:' .. cmd)
	end
end

main()

