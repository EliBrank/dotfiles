return {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = function() vim.fn["mkdp#util#install"]() end,
    init = function()
      vim.g.mkdp_browser = ''  -- Use default browser
      vim.g.mkdp_theme = 'dark'  -- or 'light'
    end,
  },
}
