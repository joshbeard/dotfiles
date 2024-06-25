require("config.lazy")

-- --------------------------------------------------------------
-- General settings
-- --------------------------------------------------------------
vim.opt.guicursor = ""

vim.cmd('colorscheme tokyonight')
vim.opt.termguicolors = true
vim.opt.shortmess = "at"

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
-- vim.g.show_whitespace = 1
-- if vim.g.show_whitespace then
--   local ag = vim.api.nvim_create_augroup('show_whitespace', { clear = true })
--   vim.api.nvim_create_autocmd('Syntax', {
--     pattern = '*',
--     command = [[syntax match TrailingWS /\v\s\ze\s*$/ containedin=ALL]],
--     group = ag,
--   })
--   vim.cmd [[highlight Tab ctermbg=240 ctermfg=240 guibg=Grey50 guifg=Grey50]]
--   vim.cmd [[highlight TrailingWS ctermbg=203 ctermfg=203 guibg=IndianRed1 guifg=IndianRed1]]
-- end

-- Colors
-- vim.cmd('colorscheme catppuccin-mocha')
-- vim.cmd('highlight Normal guibg=none ctermbg=none')
-- vim.cmd('highlight NormalFloat guibg=none ctermbg=none')
--
-- --------------------------------------------------------------
-- Keymaps
-- --------------------------------------------------------------
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("n", "Q", "<nop>")

-- move the highlighted line down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
-- move the highlighted line up
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- join lines
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "N", "Nzzzv")

-- Keymap to toggleterm
vim.api.nvim_set_keymap("n", "<leader>tt", "<cmd>ToggleTerm<cr>", {noremap = true, silent = true})

-- Vsplits
vim.keymap.set("n", "<leader>vs", ":vsplit<CR>")

-- Clipboard --
-- paste from clipboard and overwrite
vim.keymap.set("x", "<leader>p", [["_dP]])
-- copy to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
-- copy to system clipboard
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Substitute
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- chmod +x
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- nvim config
vim.keymap.set("n", "<leader>ve", "<cmd>e ~/.config/nvim/init.lua<CR>");

-- Git
vim.keymap.set("n", "<leader>gd", ":VGit project_diff_preview<CR>")
vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

-- NeoTree
vim.keymap.set("n", "<leader>nt", ":Neotree toggle<CR>")
vim.keymap.set("n", "<leader><leader>", ":Neotree toggle<CR>")

-- UndoTree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
