return {
  "ray-x/go.nvim",
  opts = {
    lsp_codelens = false,
    lsp_inlay_ints = {
      enable = false,
    },
  },
  -- config = function()
  --   -- Run gofmt + goimport on save
  --   local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
  --   vim.api.nvim_create_autocmd("BufWritePre", {
  --     pattern = "*.go",
  --     callback = function()
  --      require('go.format').goimport()
  --     end,
  --     group = format_sync_grp,
  --   })
  --
  --   -- Run gofmt on save
  --   -- local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
  --   -- vim.api.nvim_create_autocmd("BufWritePre", {
  --   --   pattern = "*.go",
  --   --   callback = function()
  --   --    require('go.format').goimport()
  --   --   end,
  --   --   group = format_sync_grp,
  --   -- })
  -- end,
}
