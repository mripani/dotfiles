return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  lazy = false,
  config = function()
    vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>")
    vim.keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>")
    vim.keymap.set("n", "<leader>fb", ":Telescope buffers<CR>")
    vim.keymap.set("n", "<leader>fo", ":Telescope lsp_document_symbols<CR>")
    vim.keymap.set("n", "<leader>fd", ":Telescope diagnostics<CR>")
  end,
}
