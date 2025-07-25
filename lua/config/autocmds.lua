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

-- Prevent strange behavior with * in CSS
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "css", "scss", "less" },
  callback = function()
    vim.opt_local.comments = ""
    vim.opt_local.formatoptions:remove("r")
    vim.opt_local.formatoptions:remove("o")
  end,
})

-- Sort Tailwind classes on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.html", "*.js", "*.jsx", "*.ts", "*.tsx", "*.vue", "*.svelte", "*.astro" },
  callback = function()
    -- Check if tailwindcss LSP is attached to current buffer
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    local has_tailwind = false

    for _, client in ipairs(clients) do
      if client.name == "tailwindcss" then
        has_tailwind = true
        break
      end
    end

    if has_tailwind then
      vim.cmd("TailwindSortSync")
    end
  end,
})
