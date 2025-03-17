local M = {}

M.dap = {
  plugin = true,
  n = {
    ["<Leader>dl"] = { "<cmd>lua require'dap'.step_into()<CR>", "Debugger step into" },
    ["<Leader>dj"] = { "<cmd>lua require'dap'.step_over()<CR>", "Debugger step over" },
    ["<Leader>dk"] = { "<cmd>lua require'dap'.step_out()<CR>", "Debugger step out" },
    ["<Leader>dc"] = { "<cmd>lua require'dap'.continue()<CR>", "Debugger continue" },
    ["<Leader>db"] = { "<cmd>lua require'dap'.toggle_breakpoint()<CR>", "Debugger toggle breakpoint" },
    ["<Leader>dd"] = {
      function()
        require("dap").set_breakpoint(vim.fn.input "Breakpoint condition: ")
      end,
      "Debugger set conditional breakpoint",
    },
    ["<Leader>de"] = { "<cmd>lua require'dap'.terminate()<CR>", "Debugger reset" },
    ["<Leader>drl"] = { "<cmd>lua require'dap'.run_last()<CR>", "Debugger run last" },
    ["<Leader>ds"] = {
      function()
        local widgets = require "dap.ui.widgets"
        local sidebar = widgets.sidebar(widgets.scopes)
        sidebar.open()
      end,
      "Debugger sidebar open",
    },
  },
}
M.dap_go = {
  plugin = true,
  n = {
    ["<Leader>dgt"] = {
      function()
        require("dap_go").debug_test()
      end,
      "Debugger run Golang test",
    },
    ["<Leader>dgl"] = {
      function()
        require("dap_go").debug_last()
      end,
      "Debugger run last Golang test",
    },
  },
}
M.gopher = {
  plugin = true,
  n = {
    ["<Leader>gj"] = {
      "<cmd> GoTagAdd json<CR>",
      "Add json struct tags",
    },
    ["<Leader>gy"] = {
      "<cmd> GoTagAdd yaml<CR>",
      "Add yaml struct tags",
    },
  },
}
M.rust = {
  n = {
    ["<Leader>drt"] = { "<cmd>RustLsp testables<CR>", "Rust Debugger testables" },
  },
}

return M
