return {
  -- add pyright and tsserver to lspconfig
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- pyright will be automatically installed with mason and loaded with lspconfig
        pyright = {},
        -- tsserver will be automatically installed with mason and loaded with lspconfig
        tsserver = {},
      },
    },
  },
}
