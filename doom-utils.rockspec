package = "doom-utils"
version = "main"
source = {
   url = "https://github.com/elf-alchemist/doom-utils.git",
   branch = "main",
}
description = {
   summary = "Doom utilities for *nix systems",
   detailed = "",
   homepage = "https://github.com/elf-alchemist/doom-utils.git",
   license = "Apache-2.0"
}
dependencies = {
   "lua >= 5.1, < 5.5"
}
build = {
   type = "builtin",
   modules = {
      wad = "src/wad.lua"
   },
}
