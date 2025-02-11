-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.relativenumber = false
vim.opt.expandtab = true -- Pressing the TAB key will insert actual tab characters
vim.opt.tabstop = 2 -- Number of spaces tabs count for
vim.g.autoformat = false -- Globally prevent autoformat on save
vim.opt.shiftwidth = 2 -- Number of spaces for auto-indentation

vim.opt.viminfo:remove('!')
