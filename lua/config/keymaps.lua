-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("i", "kj", "<Esc>", { desc = "Exit insert mode" })
vim.keymap.set("v", "kj", "<Esc>", { desc = "Exit visual mode" })

-- Manage marks
vim.keymap.set("n", "<leader>md", function()
  vim.cmd("delmarks a-zA-Z0-9")
  vim.notify("All marks cleared", vim.log.levels.INFO)
end, { desc = "Clear all marks in buffer" }
)

-- Tmux-Nvim integration
vim.keymap.set("n", "<C-h>", "<Cmd>TmuxNavigateLeft<CR>", {})
vim.keymap.set("n", "<C-j>", "<Cmd>TmuxNavigateDown<CR>", {})
vim.keymap.set("n", "<C-k>", "<Cmd>TmuxNavigateUp<CR>", {})
vim.keymap.set("n", "<C-l>", "<Cmd>TmuxNavigateRight<CR>", {})

vim.keymap.set({ "n", "v" }, "<S-C-J>", "5gj", { desc = "Move down 5 lines" })
vim.keymap.set({ "n", "v" }, "<S-NL>", "5gj", { desc = "Move down 5 lines" })
vim.keymap.set({ "n", "v" }, "<S-C-K>", "5gk", { desc = "Move up 5 lines" })

vim.keymap.set("n", "ZZ", ":qa<CR>", { desc = "Close all windows" })
