-- Core options
local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.termguicolors = true
opt.signcolumn = "yes"
opt.splitright = true
opt.splitbelow = true
opt.completeopt = "menu,menuone,noselect"
opt.ignorecase = true
opt.smartcase = true
opt.updatetime = 200

-- Persistent undo
opt.undofile = true
opt.undodir = vim.fn.stdpath("state") .. "/undo"
opt.swapfile = false
opt.backup = false
opt.writebackup = false
