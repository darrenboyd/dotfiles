return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
  keys = {
    { "<leader>gv", "<cmd>DiffviewOpen<cr>", desc = "Diffview (working tree)" },
    { "<leader>gV", "<cmd>DiffviewClose<cr>", desc = "Diffview close" },
    { "<leader>gF", "<cmd>DiffviewFileHistory %<cr>", desc = "File history (current file)" },
    { "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "Repo history" },
  },
  opts = {
    enhanced_diff_hl = true,
    view = {
      merge_tool = { layout = "diff3_mixed" },
    },
  },
}
