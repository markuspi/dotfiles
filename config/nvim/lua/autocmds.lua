require "nvchad.autocmds"

-- change to directory of opened file
if vim.fn.argc() == 1 then
  vim.api.nvim_create_autocmd("VimEnter", {
    pattern = "*",
    callback = function()
      vim.api.nvim_set_current_dir(vim.fn.expand "%:p:h")
    end,
  })
end

-- show dash when all buffers are closed
vim.api.nvim_create_autocmd("BufDelete", {
  callback = function()
    local bufs = vim.t.bufs
    if #bufs == 1 and vim.api.nvim_buf_get_name(bufs[1]) == "" then
      vim.cmd "Nvdash"
    end
  end,
})
