return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        underline = true,
        virtual_text = true,
      },
      servers = {
        ruby_lsp = {
          mason = false,
          enabled = true,
          cmd = { "/home/darren/.asdf/shims/ruby-lsp" },
        },
        solargraph = {
          enabled = false,
        },
        rubocop = {
          enabled = false,
        },
      },
    },
  },
}
