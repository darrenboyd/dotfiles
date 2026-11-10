-- nvim-lint feeds markdownlint-cli2 via stdin, which skips config discovery,
-- so point it and the conform fixer at the global config explicitly.
local config = vim.fn.expand("~/.markdownlint-cli2.yaml")

return {
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = function()
      local lint = require("lint")
      lint.linters["markdownlint-cli2"].args = { "--config", config, "-" }
      -- Style findings: signs and underlines only, no inline text on every line.
      vim.diagnostic.config({ virtual_text = false }, lint.get_namespace("markdownlint-cli2"))
    end,
  },
  {
    -- Manual only (<leader>cf): format-on-save is off for markdown, see config/autocmds.lua.
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters = {
        ["markdownlint-cli2"] = { prepend_args = { "--config", config } },
      },
    },
  },
}
