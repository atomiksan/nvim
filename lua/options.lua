require "nvchad.options"

local opt = vim.opt

opt.clipboard = "unnamedplus"
opt.confirm = true
opt.cursorline = true
opt.expandtab = true
opt.ignorecase = true
opt.inccommand = "split"
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
opt.scrolloff = 8
opt.shiftround = true
opt.shiftwidth = 2
opt.sidescrolloff = 8
opt.signcolumn = "yes"
opt.smartcase = true
opt.smartindent = true
opt.smoothscroll = true
opt.splitbelow = true
opt.splitright = true
opt.tabstop = 2
opt.timeoutlen = 400
opt.undofile = true
opt.updatetime = 200
opt.virtualedit = "block"
opt.wrap = false

vim.diagnostic.config {
  float = { border = "rounded", source = "if_many" },
  severity_sort = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  virtual_text = {
    spacing = 4,
    source = "if_many",
  },
}

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight yanked text",
  callback = function()
    vim.hl.hl_op { timeout = 180 }
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  desc = "Create missing parent directories before saving",
  callback = function(event)
    if event.match:match "^%w%w+:[\\/][\\/]" then
      return
    end

    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})
