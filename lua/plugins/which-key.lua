return {
  "folke/which-key.nvim",
  opts = function(_, opts)
    opts.spec = opts.spec or {}
    -- Add option for Obsidian
    table.insert(opts.spec, {
      { "<leader>o", group = "Obsidian" },
    })
  end,
}
