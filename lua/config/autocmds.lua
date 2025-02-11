-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
vim.api.nvim_create_autocmd("FileType", {
  pattern = "html",
  callback = function()
    local num_tabs = 2
    vim.opt_local.tabstop = num_tabs
    vim.opt_local.shiftwidth = num_tabs
    vim.opt_local.expandtab = true
  end,
})
