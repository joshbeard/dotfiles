-- https://www.troddit.com/r/neovim/comments/1cygzip/upgraded_to_010_but_getting_lsp_codelens_issues
-- https://github.com/tigh-latte/dotfiles/blob/main/.config%2Fnvim%2Flua%2Ftigh-latte%2Fplugins%2Fgo.lua#L10-L15
require('go').setup({
  lsp_codelens = false,
  lsp_inlay_hints = {
    enable = false,
  },
})

-- Run gofmt + goimport on save
local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
   require('go.format').goimport()
  end,
  group = format_sync_grp,
})

-- Run gofmt on save
-- local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   pattern = "*.go",
--   callback = function()
--    require('go.format').goimport()
--   end,
--   group = format_sync_grp,
-- })
