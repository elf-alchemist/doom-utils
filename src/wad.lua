local function fileExists(path)
    local file = io.open(path, "r")

	if file then
        file:close()
        return true
    else
        return false
    end
end

local function moveFile(src, dest)
    local status, result, code = os.execute('cp "' .. src .. '" "' .. dest .. '"')

	if not status then
        print('Error: ' .. result .. ':' .. code)
    else
        print('File ' .. src .. ' moved successfully.')
    end
end

local function find()
	local home      = os.getenv('HOME')
	local data_dir  = os.getenv('XDG_DATA_HOME') or (home .. '/.local/share')
	local steam_dir = data_dir .. '/Steam/steamapps/common'

	local steam_path = {
		doom1 = steam_dir .. '/Ultimate Doom/base/DOOM.WAD',
		doom2 = steam_dir .. '/Doom 2/base/DOOM2.WAD',
		nrftl = nil,
	}

	local dir = {
		main = data_dir .. '/doom',
		iwad = data_dir .. '/doom/iwad',
		ewad = data_dir .. '/doom/ewad',
		pwad = data_dir .. '/doom/pwad',
	}

	local wad = {
		doom1  = dir.iwad .. '/doom1.wad',
		doom2  = dir.iwad .. '/doom2.wad',
		sigil1 = dir.ewad .. '/sigil1.wad',
		sigil2 = dir.ewad .. '/sigil2.wad',
		nrftl  = dir.ewad .. '/nrftl.wad',
	}

	local sha1 = {
		doom1  = '9b07b02ab3c275a6a7570c3f73cc20d63a0e3833',
		doom2  = '7ec7652fcfce8ddc6e801839291f0e28ef1d5ae7',
		sigil1 = 'e2efdf379e1383c4e15c03de89063361897cd459',
		sigil2 = 'ad2c6e8367afbeef74e9e09b6b1e4da88c0576b4',
		nrftl  = '3451288383fb16e196f273d9f85d58c1fda97bf4',
	}

	if not fileExists(dir.main) then
		for _, path in pairs(dir) do
			local success, result, code = os.execute('mkdir -p ' .. path)

			if success then
				print('Successfully created directory')
			else
				print('Could not crete directory: ' .. path)
				print('Recieved result of ' .. result .. ':' .. code)
			end
		end
	end

	for name, path in pairs(steam_path) do
		local localPath       = wad[name]
		local steamFileExists = fileExists(path)

		if not steamFileExists then
			print('Error: file for \'' .. name .. '\' was not found.')
			print('Please check your Steam installation of \'' .. name .. '\'')
			print('Check the path \'' .. path .. '\'')
		else
			moveFile(path, localPath)
		end
	end
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

