-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Basic settings
require("core.options")
require("core.keymaps")

-- Lazy plugin manager
require("core.lazy")
