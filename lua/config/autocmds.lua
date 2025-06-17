-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Set html tabs to be 2 spaces
vim.api.nvim_create_autocmd("FileType", {
  pattern = "html",
  callback = function()
    local num_tabs = 2
    vim.opt_local.tabstop = num_tabs
    vim.opt_local.shiftwidth = num_tabs
    vim.opt_local.expandtab = true
  end,
})

-- Sort Tailwind classes on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.html", "*.js", "*.jsx", "*.ts", "*.tsx", "*.vue", "*.svelte", "*.astro" },
  callback = function ()
    vim.cmd("TailwindSortSync")
  end,
})
