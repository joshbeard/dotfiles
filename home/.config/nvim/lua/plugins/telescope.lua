return {
  "nvim-telescope/telescope.nvim",
  tag = '0.1.8',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local telescopeBuiltin = require('telescope.builtin')
    local telescope = require("telescope")
    local telescopeConfig = require("telescope.config")

    -- Clone the default Telescope configuration
    local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

    -- I want to search in hidden/dot files.
    table.insert(vimgrep_arguments, "--hidden")
    -- I don't want to search in the `.git` directory.
    table.insert(vimgrep_arguments, "--glob")
    table.insert(vimgrep_arguments, "!**/.git/*")

    -- Don't preview binaries
    local previewers = require("telescope.previewers")
    local Job = require("plenary.job")
    local exclude_binaries = function(filepath, bufnr, opts)
      filepath = vim.fn.expand(filepath)
      Job:new({
        command = "file",
        args = { "--mime-type", "-b", filepath },
        on_exit = function(j)
          local mime_type = vim.split(j:result()[1], "/")[1]
          if mime_type == "text" then
            previewers.buffer_previewer_maker(filepath, bufnr, opts)
          else
            -- maybe we want to write something to the buffer here
            vim.schedule(function()
              vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY" })
            end)
          end
        end
      }):sync()
    end

    telescope.setup({
      defaults = {
        -- `hidden = true` is not supported in text grep commands.
        vimgrep_arguments = vimgrep_arguments,
        preview = {
            filesize_limit = 0.1, -- MB
        },
        buffer_previewer_maker = exclude_binaries,
      },
      pickers = {
        find_files = {
          find_command = {
            "rg", "--files", "--hidden",
            "--glob", "!**/.git/*",
            "--glob", "!**/node_modules/*",
            "--glob", "!**/.terraform/*",
            "--glob", "!**/vendor/*",
            "--glob", "!**/__pycache__/*",
            "--glob", "!**/.venv/*",
            "--glob", "!**/.cache/*",
            "--glob", "!**/go.sum",
            "--glob", "!**/go/pkg/*",
          },
        },
      },
    })

    vim.keymap.set('n', '<leader>pf', telescopeBuiltin.find_files, {})
    vim.keymap.set('n', '<C-p>', telescopeBuiltin.git_files, {})
    vim.keymap.set('n', '<leader>ps', function()
      telescopeBuiltin.grep_string({ search = vim.fn.input("Grep > ") })
    end)
    vim.keymap.set('n', '<leader>vh', telescopeBuiltin.help_tags, {})

    -- find files in the current directory
    vim.keymap.set('n', '<leader>.', function() telescopeBuiltin.find_files({ cwd = vim.fn.expand('%:p:h') }) end)
  end,
}
