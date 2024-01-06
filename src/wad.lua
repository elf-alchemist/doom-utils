local function find()
	local home = os.getenv('HOME')
	local data_dir = os.getenv('XDG_DATA_HOME') or (home .. '/.local/share')
end

local function help()
	print(
	'Usage:\n' ..
	'    wad [-v|--version]\n' ..
	'    wad <command> [<subcommand>] [-h|--help]\n' ..
	'\n' ..
	'Managing DooM wads in POSIX environments\n' ..
	'\n' ..
	'For more information, visit https://github.com/elf-alchemist/doom-utils')
end

local command_list = {
	find = find,
	help = help,
}

local function main()
	local cmd = arg[1]

	local func = command_list[cmd]

	if (func ~= nil) then
		func()
	else
		io.stderr:write('Command not found: \'' .. cmd .. '\' try \'wad --help\'\n')
	end
end

main()

