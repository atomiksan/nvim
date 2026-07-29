# Reze's Neovim Config

Personal Neovim setup built on top of NvChad, tuned for Rust, Go, Flutter/Dart,
Nix, LSP, formatting, debugging, and fast project navigation.

The goal is simple: keep NvChad's sane defaults, but make the tools I actually
use feel ready without turning the config into a maze.

## Stack

- Base: NvChad `v2.5`
- Plugin manager: `lazy.nvim`
- Theme: `rosepine`
- LSP: Neovim's native `vim.lsp` API
- Formatting: `conform.nvim`
- Debugging: `nvim-dap`, `nvim-dap-ui`, `rustaceanvim`, `nvim-dap-go`
- UI/QoL: `noice.nvim`, `trouble.nvim`, `todo-comments.nvim`, `snacks.nvim`,
  `mini.ai`, `mini.surround`
- Tasks: `overseer.nvim`
- Navigation: Harpoon, Oil, Telescope, vim-tmux-navigator
- Treesitter: `main` branch with the current Treesitter setup

## Layout

```text
init.lua                 Bootstrap lazy.nvim, NvChad, plugins, options, mappings
lua/chadrc.lua           NvChad UI/theme config
lua/options.lua          Local editor options
lua/mappings.lua         Global keymaps
lua/configs/             Shared plugin config
lua/plugins/             Plugin specs grouped by purpose/language
lazy-lock.json           Locked plugin revisions
```

## Language Support

### Rust

Rust support is handled by `rustaceanvim`.

- `rust-analyzer` uses NvChad LSP capabilities and mappings.
- `cargo allFeatures` is enabled.
- `clippy` is used for checks.
- Debugging uses Mason's `codelldb` when available.
- Rust formatting is handled by Conform through `rustfmt`.

Important Rust keys:

| Key | Action |
| --- | --- |
| `<leader>rd` | Pick and debug a Rust target |
| `<leader>rr` | Pick and run a Rust target |
| `<leader>rt` | Pick and run Rust testables |
| `<leader>re` | Explain Rust error |
| `<leader>ca` | Rust code action |

For debugging servers, start the debug target with `<leader>rd`, then send data
from another terminal or client. DAP UI stays open after exit/termination so the
editor layout does not jump around while inspecting state.

### Go

Go support includes `gopls`, `nvim-dap-go`, and `gopher.nvim`.

- `gopls` enables inlay hints, staticcheck, placeholders, deep completion, and
  gofumpt mode.
- Formatting is handled by Conform using `goimports`, `gofumpt`, and `golines`.

Important Go keys:

| Key | Action |
| --- | --- |
| `<leader>dgt` | Debug current Go test |
| `<leader>dgl` | Debug last Go test |
| `<leader>gj` | Add JSON struct tags |
| `<leader>gy` | Add YAML struct tags |

### Flutter and Dart

Flutter support uses `flutter-tools.nvim`.

| Key | Action |
| --- | --- |
| `<leader>fr` | Flutter run |
| `<leader>fq` | Flutter quit |
| `<leader>fo` | Flutter outline |
| `<leader>fd` | Flutter devices |
| `<leader>fe` | Flutter emulators |
| `<leader>fl` | Flutter hot reload |
| `<leader>fR` | Flutter hot restart |

## Debugging

General DAP keys:

| Key | Action |
| --- | --- |
| `<leader>dc` | Continue/start |
| `<leader>do` | Step over |
| `<leader>di` | Step into |
| `<leader>dO` | Step out |
| `<leader>db` | Toggle breakpoint |
| `<leader>dB` | Conditional breakpoint |
| `<leader>dp` | Pause |
| `<leader>dt` | Terminate |
| `<leader>dL` | Run last session |
| `<leader>du` | Toggle DAP UI |
| `<leader>dR` | Toggle DAP REPL |
| `<leader>ds` | Open scopes sidebar |

DAP UI opens automatically when a debug session starts. It does not auto-close
when the program exits; use `<leader>du` when you want to hide it.

## Navigation

| Key | Action |
| --- | --- |
| `<leader>a` | Add file to Harpoon |
| `<leader>H` | Open Harpoon menu |
| `<leader>1..4` | Jump to Harpoon entry |
| `<leader>o` | Open Oil |
| `<leader>O` | Toggle floating Oil |
| `<C-h>` | Move left through tmux/Neovim panes |
| `<C-j>` | Move down through tmux/Neovim panes |
| `<C-k>` | Move up through tmux/Neovim panes |
| `<C-l>` | Move right through tmux/Neovim panes |

## Tasks

Project tasks are handled by `overseer.nvim`. Use it for one-off commands,
detected project tasks, and repeated build/test/run workflows.

| Key | Action |
| --- | --- |
| `<leader>or` | Pick and run a task |
| `<leader>ot` | Toggle task list |
| `<leader>oq` | Open task quick actions |
| `<leader>oc` | Run an arbitrary shell command as a task |

VS Code tasks report diagnostics through Neovim diagnostics and can be viewed
through Trouble.

## Editing Keys

| Key | Action |
| --- | --- |
| `;` | Enter command mode |
| `jk` | Escape insert mode |
| `<C-s>` | Save file |
| `<leader>w` | Save file |
| `<leader>q` | Quit window with confirmation |
| `<Esc>` | Clear search highlight |
| `[d` / `]d` | Previous / next diagnostic |
| `<leader>cd` | Show line diagnostics |
| `<leader>xl` | Send diagnostics to location list |
| `<leader>ti` | Toggle LSP inlay hints |
| `<leader>z` | Open a scratch buffer |
| `<leader>Z` | Select a scratch buffer |
| `gsa` / `gsd` / `gsr` | Add / delete / replace surrounding pairs |

## External Tools

This config expects these tools to be available, usually through Mason, Nix, or
your system packages:

- Rust: `rust-analyzer`, `cargo`, `rustc`, `rustfmt`, `codelldb`
- Go: `gopls`, `goimports`, `gofumpt`, `golines`, `delve`
- Nix: `nil`, `nixfmt`
- Web: `prettier`
- Lua: `stylua`
- Flutter: `flutter`, `dart`

## Health Checks

Useful checks after changing the config:

```sh
nvim --headless -u init.lua '+lua print("startup_ok")' '+qa'
nvim --headless -u init.lua '+Lazy health' '+qa'
nvim --headless -u init.lua '+Lazy load conform.nvim' '+checkhealth conform' '+qa'
```

For Rust debugging:

```sh
nvim --headless -u init.lua '+Lazy load nvim-dap' '+lua print(package.loaded.dap ~= nil)' '+qa'
```

## Maintenance Notes

- Keep `lazy-lock.json` committed when plugin versions change.
- `nvim-treesitter` follows its `main` branch in this config.
- Use `:Lazy sync` after changing plugin specs.
- Use `:Mason` to inspect or install external LSP/debug/formatter tools.
