local map = vim.keymap.set

-- Save / quit
map("n", "<leader>w", "<cmd>w<cr>")
map("n", "<leader>q", "<cmd>q<cr>")

-- Clear highlight
map("n", "<leader>h", "<cmd>nohlsearch<cr>")

-- Better splits
map("n", "<C-h>", "<C-w>h")
map("n", "<C-l>", "<C-w>l")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
