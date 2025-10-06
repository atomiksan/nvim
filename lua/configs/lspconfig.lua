-- -- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()
local nvlsp = require "nvchad.configs.lspconfig"

local servers = { "html", "cssls", "nil_ls", "gopls", "clangd" }
vim.lsp.enable(servers)

-- override server-specific config:

vim.lsp.config("nil_ls", {
  autostart = true,
  on_attach = nvlsp.on_attach,
  capabilities = nvlsp.capabilities,
  settings = {
    ["nil"] = {
      formatting = { command = { "nixfmt" } },
      single_file_support = true,
      autoArchive = true,
    },
  },
})

vim.lsp.config("gopls", {
  on_attach = nvlsp.on_attach,
  capabilities = nvlsp.capabilities,
  settings = {
    gopls = {
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
      analyses = { unusedparams = true },
      staticcheck = true,
      gofumpt = true,
      usePlaceholders = true,
      completeUnimported = true,
      deepCompletion = true,
      directoryFilters = { "-node_modules" },
    },
  },
})

vim.lsp.config("clangd", {
  on_attach = function(client, bufnr)
    if nvlsp.on_attach then
      nvlsp.on_attach(client, bufnr)
    end
    if client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint.enable(true)
    end
  end,
  capabilities = nvlsp.capabilities,
})

-- For formatting on save:
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    vim.lsp.buf.format { async = false }
  end,
})
