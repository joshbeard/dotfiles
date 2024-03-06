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

-- vim.keymap.set("n", "<leader>vwm", function()
--     require("vim-with-me").StartVimWithMe()
-- end)
-- vim.keymap.set("n", "<leader>svwm", function()
  vim.keymap.set("n", "n", "nzzzv")
--     require("vim-with-me").StopVimWithMe()
-- end)

-- Toggle NeoTree
vim.keymap.set("n", "<leader>nt", ":Neotree toggle<CR>")
vim.keymap.set("n", "<leader><leader>", ":Neotree toggle<CR>")
--
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

-- UndoTree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- Substitute
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- chmod +x
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- nvim config
vim.keymap.set("n", "<leader>vpc", "<cmd>e ~/.config/nvim/init.lua<CR>");
vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.config/nvim/lua/joshbeard/packer.lua<CR>");

-- Git
vim.keymap.set("n", "<leader>gd", ":VGit project_diff_preview<CR>")
vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

-- Harpoon
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")
vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<leader>o", ui.toggle_quick_menu)

vim.keymap.set("n", "<C-j>", function() ui.nav_file(1) end)
vim.keymap.set("n", "<C-k>", function() ui.nav_file(2) end)
vim.keymap.set("n", "<C-l>", function() ui.nav_file(3) end)
vim.keymap.set("n", "<C-;>", function() ui.nav_file(4) end)

-- DAP - Debug Adapter Protocol
vim.keymap.set("n", '<leader>dk', function() require('dap').continue() end)
vim.keymap.set("n", '<leader>dl', function() require('dap').run_last() end)
vim.keymap.set("n", '<leader>b', function() require('dap').toggle_breakpoint() end)
