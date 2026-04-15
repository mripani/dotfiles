-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<leader>fy", function()
  local diag = vim.diagnostic.get(0, { lnum = vim.api.nvim_win_get_cursor(0)[1] - 1 })[1]
  if diag then
    vim.fn.setreg("+", diag.message)
    vim.notify("Diagnostic yanked", vim.log.levels.INFO)
  else
    vim.notify("No diagnostic on this line", vim.log.levels.WARN)
  end
end, { desc = "Yank diagnostic message" })
