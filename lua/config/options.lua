-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.relativenumber = true
vim.g.autoformat = false -- Globally prevent autoformat on save

-- local num_tabs = 4
-- vim.opt.expandtab = true -- Pressing the TAB key will insert actual tab characters
-- vim.opt.tabstop = num_tabs -- Number of spaces tabs count for
-- vim.opt.shiftwidth = num_tabs -- Number of spaces for auto-indentation

vim.opt.viminfo:remove('!')
