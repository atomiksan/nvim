-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = { "html", "cssls" }
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- configuring single server, example: typescript
-- lspconfig.ts_ls.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }

-- LSP nix setup
lspconfig.nil_ls.setup {
  autostart = true,
  on_attach = nvlsp.on_attach,
  capabilities = nvlsp.capabilities,
  settings = {
    ["nil"] = {
      formatting = {
        command = { "nixfmt" }, -- Ensure you have nixpkgs-fmt installed
      },
      single_file_support = true,
      autoArchive = true,
    },
  },
}

-- LSP gopls setup
lspconfig.gopls.setup {
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
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      gofumpt = true,
      usePlaceholders = true,
      completeUnimported = true, -- Enables auto-importing
      deepCompletion = true,
      directoryFilters = { "-node_modules" },
    },
  },
}

-- Autoformat and organize imports on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    vim.lsp.buf.format { async = false }
  end,
})

-- LSP clangd setup
lspconfig.clangd.setup {
  on_init = nvlsp.on_init,
  on_attach = function(client, bufnr)
    -- Call the default NvChad on_attach
    if nvlsp.on_attach then
      nvlsp.on_attach(client, bufnr)
    end

    -- Enable inlay hints if the LSP supports it
    if client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint.enable(true)
    end
  end,
  capabilities = nvlsp.capabilities,
}
