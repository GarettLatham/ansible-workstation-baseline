-- Minimal entrypoint
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.options")
require("config.diagnostics")
require("config.lazy")
require("config.keymaps")
require("config.autocmds")
