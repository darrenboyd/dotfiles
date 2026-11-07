-- nvim-lint feeds markdownlint-cli2 via stdin, which skips config discovery,
-- so point it at the global config explicitly.
return {
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = function()
      local linter = require("lint").linters["markdownlint-cli2"]
      linter.args = { "--config", vim.fn.expand("~/.markdownlint-cli2.yaml"), "-" }
    end,
  },
}
