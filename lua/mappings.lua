require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
vim.keymap.set("n", "<leader>ti", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "Toggle Inlay Hints" })

local custom_mappings = require "custom.mappings"
--
-- for _, group in pairs(custom_mappings) do
--   for mode, maps in pairs(group) do
--     -- Skip non-mode keys, e.g. the "plugin" flag if present
--     if mode ~= "plugin" then
--       for lhs, mapping in pairs(maps) do
--         local rhs = mapping[1]
--         local desc = mapping[2]
--         map(mode, lhs, rhs, { desc = desc })
--       end
--     end
--   end
-- end

local function load_mappings(group_name)
  local mappings = custom_mappings[group_name]
  if not mappings then
    return
  end

  for mode, maps in pairs(mappings) do
    -- Skip non-mode keys, e.g., the "plugin" flag if present
    if mode ~= "plugin" then
      for lhs, mapping in pairs(maps) do
        local rhs = mapping[1]
        local desc = mapping[2]
        map(mode, lhs, rhs, { desc = desc })
      end
    end
  end
end

-- 🌟 Lazy loading based on plugin/file type
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "go" }, -- Load Go-specific mappings
  callback = function()
    load_mappings "dap_go"
    load_mappings "gopher"
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "rust" }, -- Load Rust-specific mappings
  callback = function()
    load_mappings "rust"
  end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    -- Check if nvim-dap is available before loading mappings
    local has_dap, _ = pcall(require, "dap")
    if has_dap then
      load_mappings "dap"
    end
  end,
})
