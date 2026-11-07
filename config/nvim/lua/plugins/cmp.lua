return {
  "hrsh7th/nvim-cmp",
  dependencies = { "hrsh7th/cmp-emoji" },
  ---@param opts cmp.ConfigSchema
  opts = function(_, opts)
    opts.preselect = cmp.PreselectMode.None
    opts.completion = {
      completeopt = "noselect",
    }
    opts.experimental.ghost_text = false

    opts.mapping = vim.tbl_extend("force", opts.mapping, {
      ["<CR>"] = cmp.mapping.confirm({ select = false }),
    })
  end,
}
