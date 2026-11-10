-- Read and edit modes for markdown files.
--
-- read: rendered by render-markdown, no diagnostics, no spell, not modifiable.
-- edit: raw text, lint and spell on, modifiable.
--
-- Files open in read mode (new or empty files open in edit mode). Switch with
-- <leader>ue or :MarkdownToggle, :MarkdownRead, :MarkdownEdit. The mode is per buffer.
local M = {}

local filetypes = { "markdown", "markdown.mdx" }

-- Only real files: LSP hover and noice also use filetype=markdown on scratch buffers.
local function is_file(buf)
  return vim.bo[buf].buftype == "" and vim.api.nvim_buf_get_name(buf) ~= ""
end

local function is_empty(buf)
  return vim.api.nvim_buf_line_count(buf) == 1 and vim.api.nvim_buf_get_lines(buf, 0, 1, false)[1] == ""
end

local function set_spell(buf, on)
  for _, win in ipairs(vim.fn.win_findbuf(buf)) do
    vim.wo[win].spell = on
  end
end

function M.apply(buf)
  if not vim.api.nvim_buf_is_valid(buf) then
    return
  end
  local mode = vim.b[buf].markdown_mode
  if not mode then
    return
  end
  local read = mode == "read"
  vim.bo[buf].modifiable = not read
  vim.diagnostic.enable(not read, { bufnr = buf })
  set_spell(buf, not read)
  local ok, render = pcall(require, "render-markdown")
  if ok then
    vim.api.nvim_buf_call(buf, function()
      render.set_buf(read)
    end)
  end
end

function M.set(buf, mode)
  buf = buf ~= 0 and buf or vim.api.nvim_get_current_buf()
  if not vim.tbl_contains(filetypes, vim.bo[buf].filetype) then
    vim.notify("Not a markdown buffer", vim.log.levels.WARN)
    return
  end
  vim.b[buf].markdown_mode = mode
  M.apply(buf)
  if mode == "edit" then
    pcall(function()
      require("lint").try_lint()
    end)
  end
end

function M.toggle(buf)
  buf = buf ~= 0 and buf or vim.api.nvim_get_current_buf()
  M.set(buf, vim.b[buf].markdown_mode == "read" and "edit" or "read")
end

function M.setup()
  local group = vim.api.nvim_create_augroup("markdown_mode", { clear = true })

  vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = filetypes,
    callback = function(ev)
      local buf = ev.buf
      if not is_file(buf) then
        return
      end
      if vim.b[buf].markdown_mode == nil then
        vim.b[buf].markdown_mode = is_empty(buf) and "edit" or "read"
      end
      vim.keymap.set("n", "<leader>ue", function()
        M.toggle(buf)
      end, { buffer = buf, desc = "Toggle Markdown Read/Edit" })
      -- Scheduled so it runs after LazyVim's FileType autocmd turns spell on.
      vim.schedule(function()
        M.apply(buf)
      end)
    end,
  })

  -- spell is window-local: set it again when the buffer is shown in another window.
  vim.api.nvim_create_autocmd("BufWinEnter", {
    group = group,
    callback = function(ev)
      local mode = vim.b[ev.buf].markdown_mode
      if mode then
        vim.wo.spell = mode == "edit"
      end
    end,
  })

  vim.api.nvim_create_user_command("MarkdownRead", function()
    M.set(0, "read")
  end, { desc = "Markdown: read mode" })
  vim.api.nvim_create_user_command("MarkdownEdit", function()
    M.set(0, "edit")
  end, { desc = "Markdown: edit mode" })
  vim.api.nvim_create_user_command("MarkdownToggle", function()
    M.toggle(0)
  end, { desc = "Markdown: toggle read/edit mode" })
end

return M
