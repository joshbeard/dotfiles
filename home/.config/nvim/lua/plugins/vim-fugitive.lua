return {
  "tpope/vim-fugitive",
  config = function()
    local JoshBeard_Fugitive = vim.api.nvim_create_augroup("JoshBeard_Fugitive", {})

    local autocmd = vim.api.nvim_create_autocmd
    autocmd("BufWinEnter", {
        group = JoshBeard_Fugitive,
        pattern = "*",
        callback = function()
            if vim.bo.ft ~= "fugitive" then
                return
            end

            local bufnr = vim.api.nvim_get_current_buf()
            local opts = {buffer = bufnr, remap = false}
            vim.keymap.set("n", "<leader>p", function()
                vim.cmd.Git('push')
            end, opts)

            -- rebase always
            vim.keymap.set("n", "<leader>P", function()
                vim.cmd.Git({'pull',  '--rebase'})
            end, opts)

            vim.keymap.set("n", "<leader>t", ":Git push -u origin ", opts);
        end,
    })
  end,
}
