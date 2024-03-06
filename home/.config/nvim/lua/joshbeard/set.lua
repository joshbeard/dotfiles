-- --------------------------------------------------------------
-- General settings
-- --------------------------------------------------------------
vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80,100,120"

-- Set statusline
vim.opt.statusline = "%f %m %r %y %w %="
vim.opt.statusline = vim.opt.statusline + "%{&ff} %h %l/%L %c %V %P"

-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
-- vim.opt.foldlevelstart = 99

-- Options for vgit
-- vim.opt.incsearch = false
--

vim.wo.signcolumn = 'yes'
vim.o.updatetime = 300

-- Highlight trailing whitespace --
vim.o.termguicolors = true
vim.o.mouse = ''
vim.cmd [[syn on]]
vim.g.show_whitespace = 1
if vim.g.show_whitespace then
  local ag = vim.api.nvim_create_augroup('show_whitespace', { clear = true })
  vim.api.nvim_create_autocmd('Syntax', {
    pattern = '*',
    command = [[syntax match TrailingWS /\v\s\ze\s*$/ containedin=ALL]],
    group = ag,
  })
  vim.cmd [[highlight Tab ctermbg=240 ctermfg=240 guibg=Grey50 guifg=Grey50]]
  vim.cmd [[highlight TrailingWS ctermbg=203 ctermfg=203 guibg=IndianRed1 guifg=IndianRed1]]
end

-- Colors
-- vim.cmd('colorscheme catppuccin-mocha')
-- vim.cmd('highlight Normal guibg=none ctermbg=none')
-- vim.cmd('highlight NormalFloat guibg=none ctermbg=none')

