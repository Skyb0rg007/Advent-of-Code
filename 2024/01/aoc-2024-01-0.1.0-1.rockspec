package = "aoc-2024-01"
version = "0.1.0-1"
source = {
   url = "git+ssh://git@github.com/Skyb0rg007/Advent-of-Code.git",
   tag = "0.1.0"
}
description = {
   homepage = "https://github.com/Skyb0rg007/Advent-of-Code",
   license = "MIT"
}
dependencies = {
   "lua >= 5.1, < 5.5",
   "inspect ~> 3.1"
}
build = {
   type = "builtin",
   modules = {
   },
   install = {
       bin = {
           ["day1"] = "solution.lua"
       }
   }
}
