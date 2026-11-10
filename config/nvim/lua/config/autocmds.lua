-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Never format these on save; <leader>cf still formats on demand.
-- markdown: markdownlint-cli2 --fix rewrites AI-generated files wholesale.
-- sh (bash too): shfmt re-indents with tabs and rewrites backticks.
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("no_autoformat", { clear = true }),
  pattern = { "markdown", "markdown.mdx", "sh" },
  callback = function(ev)
    vim.b[ev.buf].autoformat = false
  end,
})

-- Markdown read/edit modes (<leader>ue). See lua/util/markdown_mode.lua.
require("util.markdown_mode").setup()
