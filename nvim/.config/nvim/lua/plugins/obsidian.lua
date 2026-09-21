return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- use latest release, remove to use latest commit
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    legacy_commands = false, -- this will be removed in 4.0.0
    workspaces = {
      {
        name = "Main",
        path = "~/Documents/Main",
      },
    },
    ui = {
      enable = false
    },
    checkbox = {
      order = { " ", "x" },
    },
  },
  -- keys = {
  --   {
  --     "<leader>ob",
  --     "<cmd>Obsidian backlinks<cr>",
  --     desc = "Backlinks",
  --     ft = "markdown",
  --   },
  --   {
  --     "<leader>of",
  --     "<cmd>ObsidianQuickSwitch<cr>",
  --     desc = "Quick Switch",
  --     ft = "markdown",
  --   },
  --   {
  --     "<leader>on",
  --     "<cmd>ObsidianNew<cr>",
  --     desc = "New Note",
  --     ft = "markdown",
  --   },
  --   {
  --     "<leader>or",
  --     "<cmd>ObsidianRename<cr>",
  --     desc = "Rename Note",
  --     ft = "markdown",
  --   },
  --   {
  --     "<leader>ot",
  --     "<cmd>ObsidianTags<cr>",
  --     desc = "Tags",
  --     ft = "markdown",
  --   },
  -- },
}
