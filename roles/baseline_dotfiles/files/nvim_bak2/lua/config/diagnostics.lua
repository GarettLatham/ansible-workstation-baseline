-- Diagnostics behavior (VSCode-ish)
vim.diagnostic.config({
  virtual_text = false,
  severity_sort = true,
  underline = true,
  update_in_insert = false,
  float = { border = "rounded", source = "always" },
})
