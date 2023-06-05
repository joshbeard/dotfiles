require('nvim_comment').setup()

-- Only for Terraform files
vim.api.nvim_exec([[
augroup terraform
  autocmd!
  autocmd FileType terraform setlocal commentstring=#\ %s
augroup END
]], false)

