#!/usr/bin/env lua

local env_home = os.getenv("HOME")
local env_data_dir = os.getenv("XDG_DATA_HOME") or (env_home .. "/.local/share")

local env_steam_dir = env_data_dir .. "/Steam/steamapps/common"
local env_doom_dir = env_data_dir .. "/games/doom"

local steam_path = {
	doom1 = env_steam_dir .. "/Ultimate Doom/base/DOOM.WAD",
	doom2 = env_steam_dir .. "/Doom 2/base/DOOM2.WAD",
	nrftl = nil,
}

local wad = {
	doom1 = env_doom_dir .. "/doom1.wad",
	doom2 = env_doom_dir .. "/doom2.wad",
	sigil1 = env_doom_dir .. "/sigil1.wad",
	sigil2 = env_doom_dir .. "/sigil2.wad",
	nrftl = env_doom_dir .. "/nrftl.wad",
}

local sha1 = {
	doom1 = "9b07b02ab3c275a6a7570c3f73cc20d63a0e3833",
	doom2 = "7ec7652fcfce8ddc6e801839291f0e28ef1d5ae7",
	sigil1 = "e2efdf379e1383c4e15c03de89063361897cd459",
	sigil2 = "ad2c6e8367afbeef74e9e09b6b1e4da88c0576b4",
	nrftl = "3451288383fb16e196f273d9f85d58c1fda97bf4",
}

---@param path string
local function fileExists(path)
	local file = io.open(path, "r")

	if file then
		file:close()
		return true
	else
		return false
	end
end

---@param src  string
---@param dest string
local function moveFile(src, dest)
	local successful, result, code = os.execute(string.format("cp '%s' '%s'", src, dest))

	if not successful then
		io.stderr:write(string.format("Error:%s->%s", result, code))
	else
		io.stdout:write(string.format("File %s moved successfully.", src))
	end
end

---@param path string
local function makeDirectory(path)
	local success, result, code = os.execute("mkdir -p " .. path)

	if success then
		io.stdout:write("Successfully created directory\n")
	else
		io.stderr:write(
			string.format("Could not crete directory: %s\n", path),
			string.format("Recieved result of %s:%s\n", result, code)
		)
	end
end

local function find()
	if not fileExists(env_doom_dir) then
		makeDirectory(env_doom_dir)
	end

	for name, path in pairs(steam_path) do
		local localPath = wad[name]
		local steamFileExists = fileExists(path)

		if not steamFileExists then
			io.stderr:write(
				string.format("Error: file for '%s' was not found.\n", name),
				string.format("Please check your Steam installation of '%s'\n", name),
				string.format("Check the path '%s'\n", path)
			)
		else
			moveFile(path, localPath)
		end
	end

	return 0
end

local function path()
	io.stdout:write(string.format("export DOOMWADDIR='%s';\n", env_doom_dir))
	return 0
end

local function help()
	io.stdout:write(
		string.format("Usage:\n"),
		string.format("    wad find\n"),
		string.format("    wad path\n"),
		string.format("    wad help\n"),
		string.format("    wad version\n"),
		string.format("\n"),
		string.format("Manage Doom wads in POSIX environments\n"),
		string.format("For more information, visit https://github.com/elf-alchemist/doom-utils\n"),
		string.format("\n")
	)
	return 0
end

local function version()
	io.stdout:write(
		string.format("Doom utils - version 0.0.1\n"),
		string.format("\n"),
		string.format("Utilities to work with doom engine games, this package includes:\n"),
		string.format("    wad - Manage, and work with, wad files\n"),
		string.format("\n")
	)
	return 0
end

local command_list = {
	find = find,
	path = path,
	help = help,
	version = version,
}

local function main()
	for i = 0, #arg do
		if arg[i] == "--help" then
			help()
			os.exit(0)
		end
	end

	local cmd = arg[1]

	local func = command_list[cmd]

	if func then
		local status = func()
		os.exit(status)
	else
		io.stderr:write(string.format("Command not found: '%s' try 'wad help'\n", cmd))
		os.exit(1)
	end
end

main()
