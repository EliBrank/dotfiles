return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' },            -- if you use the mini.nvim suite
  -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
  -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    render_modes = { 'n', 'c', 't' }
  },

  config = function(_, opts)
    vim.api.nvim_set_hl(0, "RenderMarkdownH1Bg", { bg = "#504945" })
    vim.api.nvim_set_hl(0, "RenderMarkdownH2Bg", { bg = "#45403d" })
    vim.api.nvim_set_hl(0, "RenderMarkdownH3Bg", { bg = "#3f3b38" })
    vim.api.nvim_set_hl(0, "RenderMarkdownH4Bg", { bg = "#3a3735" })
    vim.api.nvim_set_hl(0, "RenderMarkdownH5Bg", { bg = "#353331" })
    vim.api.nvim_set_hl(0, "RenderMarkdownH6Bg", { bg = "#302f2d" })
    require("render-markdown").setup(opts)
  end,

}
