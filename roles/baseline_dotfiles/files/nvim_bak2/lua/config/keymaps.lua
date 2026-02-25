local map = vim.keymap.set

-- Neo-tree
map("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Explorer" })
map("n", "<leader>o", "<cmd>Neotree focus<cr>", { desc = "Focus tree" })

-- Telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })
map("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Recent files" })
map("n", "<leader>fc", "<cmd>Telescope git_commits<cr>", { desc = "Git commits" })
map("n", "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", { desc = "Symbols (document)" })
map("n", "<leader>fS", "<cmd>Telescope lsp_workspace_symbols<cr>", { desc = "Symbols (workspace)" })
map("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>", { desc = "Find diagnostics" })

-- Telescope (ripgrep power search via live_grep_args)
map("n", "<leader>fG", function()
  require("telescope").extensions.live_grep_args.live_grep_args()
end, { desc = "Live grep (args)" })

-- Bufferline
map("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
map("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
map("n", "<leader>bp", "<cmd>BufferLinePick<cr>", { desc = "Pick buffer" })
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Close buffer" })

-- Trouble
map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })

-- Terminal toggle (horizontal)
map("n", "<C-\\>", "<cmd>ToggleTerm direction=horizontal<cr>", { desc = "Terminal (horizontal)" })
map("t", "<C-\\>", [[<C-\><C-n><cmd>ToggleTerm direction=horizontal<cr>]], { desc = "Terminal (horizontal)" })
map("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })
