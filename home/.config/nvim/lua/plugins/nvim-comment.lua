return {
  "terrortylor/nvim-comment",
  config = function()
    vim.api.nvim_exec([[
    augroup terraform
      autocmd!
      autocmd FileType terraform setlocal commentstring=#\ %s
    augroup END
    ]], false)
  end,
}
