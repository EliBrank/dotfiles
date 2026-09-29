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

    note_id_func = function(title)
      local timestamp = os.date("%Y%m%d-%H%M%S")
      return (title or "Untitled") .. " - " .. timestamp
    end,

    frontmatter = {
      func = function(note)
        if note.title then
          note:add_alias(note.title)
        end

        return {
          id = note.id,
          aliases = note.aliases,
          tags = note.tags,
        }
      end
    },
  },

  ft = "markdown",
  keys = {
    {
      "<leader>ob",
      "<cmd>Obsidian backlinks<cr>",
      desc = "Backlinks",
      ft = "markdown",
    },
    {
      "<leader>of",
      "<cmd>Obsidian quick_switch<cr>",
      desc = "Quick Switch",
      ft = "markdown",
    },
    {
      "<leader>on",
      "<cmd>Obsidian new<cr>",
      desc = "New Note",
      ft = "markdown",
    },
    {
      "<leader>or",
      "<cmd>Obsidian rename<cr>",
      desc = "Rename Note",
      ft = "markdown",
    },
    {
      "<leader>ot",
      "<cmd>Obsidian tags<cr>",
      desc = "Tags",
      ft = "markdown",
    },
  },
}
