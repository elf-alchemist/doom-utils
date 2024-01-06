rockspec_format = "1.1"
package = "doom-utils"
version = "main-1"
source = {
   url = "https://github.com/elf-alchemist/doom-utils",
   branch = "main",
}
description = {
   summary = "Doom utilities for *nix systems",
   detailed = "",
   homepage = "https://github.com/elf-alchemist/doom-utils",
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
