-- lua/config/autocmds.lua
-- Autocommands (safe with Snacks dashboard)

local function launched_without_file_args()
return vim.fn.argc() == 0
end

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
  if not launched_without_file_args() then
    return
    end

    -- Prefer Snacks dashboard if installed
    local ok_snacks, snacks = pcall(require, "snacks")
    if ok_snacks and snacks.dashboard then
      pcall(function()
      snacks.dashboard.open()
      end)
      return
      end

      -- Fallback: show file tree + terminal (only if no dashboard)
pcall(function()
require("neo-tree.command").execute({
  action = "show",
  source = "filesystem",
  position = "left",
})
end)

vim.defer_fn(function()
pcall(vim.cmd, "ToggleTerm direction=horizontal")
end, 50)
end,
})

vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "term://*toggleterm#*",
  callback = function()
  vim.cmd("startinsert")
  end,
})
