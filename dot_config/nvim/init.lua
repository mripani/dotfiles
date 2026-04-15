-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
vim.opt.number = true                -- absolute numbers
vim.opt.relativenumber = true        -- relative numbers

-- Folding (treesitter-based)
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99

vim.keymap.set('n', 'zO', 'zR', { desc = 'Open all folds' })
vim.keymap.set('n', 'zC', 'zM', { desc = 'Close all folds' })
