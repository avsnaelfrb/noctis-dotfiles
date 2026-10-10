# noctis-dotfiles

This is my personal Terminal setup, kept in one repo as a mono-repo inside `~/.config`.
Feel free to clone it, poke around, and take whatever's useful.

Only 7 folders are tracked here — everything else is filtered out by a whitelist-style
`.gitignore`, so no caches, logs, or secrets ever sneak in.

| Folder | What it's for | Source |
|---|---|---|
| `alacritty/` | Alacritty terminal emulator | https://github.com/alacritty/alacritty |
| `kitty/` | kitty terminal emulator | https://github.com/kovidgoyal/kitty |
| `nvim/` | Neovim config (Lua) | https://github.com/neovim/neovim |
| `fish/` | Fish shell | https://github.com/fish-shell/fish-shell |
| `ghostty/` | Ghostty terminal emulator | https://github.com/ghostty-org/ghostty |
| `herdr/` | Herdr — agent-aware terminal multiplexer (Rust) | https://github.com/herdrdev/herdr |
| `micro/` | Micro terminal text editor | https://github.com/zyedidia/micro |

---

## Requirements

### Core apps
You'll want the apps that these configs belong to:

- **Alacritty** — https://github.com/alacritty/alacritty
- **kitty** — https://github.com/kovidgoyal/kitty
- **Neovim** `>= 0.11` (latest stable or nightly recommended) — https://github.com/neovim/neovim
- **Fish shell** — https://github.com/fish-shell/fish-shell
- **Ghostty** — https://github.com/ghostty-org/ghostty
- **Herdr** — https://github.com/herdrdev/herdr
- **micro** — https://github.com/zyedidia/micro

### Supporting tools
- **git** — https://git-scm.com
- **ripgrep** (`rg`) — used by mini.pick for file/grep search → https://github.com/BurntSushi/ripgrep
- **A Nerd Font** (e.g. FiraCode) — for the icons/statusline → https://github.com/ryanoasis/nerd-fonts
  The Ghostty config expects `FiraCode Nerd Font`, so either install it or tweak `font-family` in `ghostty/config.ghostty`.
- **Node.js + npm** (for the TypeScript/Vue language servers via Mason) — https://nodejs.org

---

## Installation

### 1. Clone the repo

```bash
git clone https://github.com/avsnaelfrb/noctis-dotfiles.git ~/dotfiles
```

### 2. Install the configs

**Option A — Use the script (easiest):**

```bash
cd ~/noctis-dotfiles
./install.sh          # symlink (default, recommended)
./install.sh --copy   # or copy the files instead
```

Any existing config gets backed up to `<folder>.bak.<timestamp>` before it's touched.

**Option B — Symlink manually:**

```bash
for d in alacritty kitty nvim fish ghostty herdr micro; do
  mkdir -p ~/.config
  # back up an existing (non-symlink) config first
  if [ -e "$HOME/.config/$d" ] && [ ! -L "$HOME/.config/$d" ]; then
    mv "$HOME/.config/$d" "$HOME/.config/$d.bak"
  fi
  ln -sfn "$HOME/dotfiles/$d" "$HOME/.config/$d"
done
```

**Option C — Just copy:**

```bash
cd ~/dotfiles
cp -r alacritty kitty nvim fish ghostty herdr micro ~/.config/
```

### 3. Let Neovim finish setting itself up

Open Neovim and the plugins install themselves via **lazy.nvim** (versions are pinned in
`lazy-lock.json`), while **Mason** pulls down the language servers automatically.

```bash
nvim
```

Handy commands once you're in:
- `:Lazy` → manage plugins (`:Lazy sync`)
- `:Mason` → check language server status

### 4. Fish shell (optional)

`fish/config.fish` sources a file that ships with CachyOS:

```fish
source /usr/share/cachyos-fish-config/cachyos-config.fish
```

If you're **not** on CachyOS, just comment that line out.

---

## What's in each config

### Neovim (`nvim/`)
- Plugin manager: **lazy.nvim** (auto-bootstraps, versions locked via `lazy-lock.json`).
- Layout:
  - `init.lua` — entry point
  - `lua/config/` — `options.lua`, `keymaps.lua`, `autocmds.lua`
  - `lua/plugins/` — plugin specs
  - `lua/lsp/` — per-server settings
- Highlights: Catppuccin theme, LSP + completion (mini.nvim), Treesitter, file explorers
  (neo-tree & oil), formatting (conform.nvim), picker (mini.pick), statusline (lualine).

### Ghostty (`ghostty/`)
Custom GitHub-dark palette, `background-opacity = 0.85` with blur, FiraCode Nerd Font,
zsh shell integration, and `window-decoration = none`.

### Herdr (`herdr/`)
`catppuccin` theme, `ctrl+;` prefix, `kitty_graphics = true`. Only `config.toml` is tracked —
runtime state (sessions, snapshots, logs) is ignored.

### micro (`micro/`)
`ayu-dark` colorscheme, no custom keybindings. Extra themes live in `colorschemes/`
(Catppuccin, Ayu). Micro's bundled syntax files aren't tracked (they're auto-generated).

### Alacritty / kitty / fish
Basic terminal and shell config (theme, font, shell behavior). Take a look at the actual
files: `alacritty/alacritty.toml`, `kitty/kitty.conf`, `fish/config.fish`.

---

## Plugins & libraries

### Neovim plugins
| Plugin | URL |
|---|---|
| lazy.nvim | https://github.com/folke/lazy.nvim |
| catppuccin | https://github.com/catppuccin/nvim |
| conform.nvim | https://github.com/stevearc/conform.nvim |
| friendly-snippets | https://github.com/rafamadriz/friendly-snippets |
| indent-blankline.nvim | https://github.com/lukas-reineke/indent-blankline.nvim |
| lualine.nvim | https://github.com/nvim-lualine/lualine.nvim |
| nvim-web-devicons | https://github.com/nvim-tree/nvim-web-devicons |
| mason.nvim | https://github.com/mason-org/mason.nvim |
| mason-lspconfig.nvim | https://github.com/mason-org/mason-lspconfig.nvim |
| nvim-lspconfig | https://github.com/neovim/nvim-lspconfig |
| SchemaStore.nvim | https://github.com/b0o/SchemaStore.nvim |
| mini.nvim | https://github.com/echasnovski/mini.nvim |
| neo-tree.nvim | https://github.com/nvim-neo-tree/neo-tree.nvim |
| nui.nvim | https://github.com/MunifTanjim/nui.nvim |
| plenary.nvim | https://github.com/nvim-lua/plenary.nvim |
| oil.nvim | https://github.com/stevearc/oil.nvim |
| oil-git-status.nvim | https://github.com/refractalize/oil-git-status.nvim |
| nvim-treesitter | https://github.com/nvim-treesitter/nvim-treesitter |
| zdiff.nvim | https://github.com/martindur/zdiff.nvim |
| tiny-cmdline.nvim | https://github.com/rachartier/tiny-cmdline.nvim |

### Language servers (installed automatically by Mason)
| Server | Language | URL |
|---|---|---|
| `lua_ls` | Lua | https://github.com/LuaLS/lua-language-server |
| `basedpyright` | Python | https://github.com/DetachHead/basedpyright |
| `ts_ls` | JavaScript/TypeScript (+ Vue) | https://github.com/typescript-language-server/typescript-language-server |
| `vue_ls` | Vue | https://github.com/vuejs/language-tools |
| `jsonls` | JSON | https://github.com/hrsh7th/vscode-langservers-extracted |
| `yamlls` | YAML | https://github.com/redhat-developer/yaml-language-server |
| `just` | justfile | https://mason-registry.dev/registry/list |

> For Vue projects, `ts_ls` uses `@vue/typescript-plugin`
> (https://github.com/vuejs/language-tools) — `nvim/lua/plugins/lsp.lua` points to
> `mason/packages/vue-language-server/node_modules/@vue/typescript-plugin`.

### Formatters (used by conform.nvim, install separately)
| Formatter | Language | URL |
|---|---|---|
| `stylua` | Lua | https://github.com/JohnnyMorganz/StyLua |
| `prettierd` | JS/TS/JSON/Vue/GraphQL | https://github.com/fsouza/prettierd |
| `eslint_d` | JS/TS | https://github.com/mantoni/eslint_d.js |
| Biome | JS/TS (optional, detected via `biome.json`) | https://github.com/biomejs/biome |
| `goimports` | Go | https://pkg.go.dev/golang.org/x/tools/cmd/goimports |
| `shfmt` | Shell | https://github.com/mvdan/sh |
| `sql_formatter` | SQL | https://github.com/sql-formatter-org/sql-formatter |

### Other tools
| Tool | Purpose | URL |
|---|---|---|
| ripgrep (`rg`) | file/grep search in mini.pick | https://github.com/BurntSushi/ripgrep |
| Nerd Fonts | icons/powerline glyphs | https://github.com/ryanoasis/nerd-fonts |

---

## Notes

- This repo uses a whitelist `.gitignore`: only the 7 folders above are tracked. Runtime
  files (logs, sockets, Herdr sessions/snapshots, micro backups/buffers, `micro/syntax/`)
  never get committed.
- To update: `cd ~/dotfiles && git pull` (with symlinks, your config updates instantly).
- Old configs are saved as `*.bak` folders under `~/.config/` — restore them if you ever
  want to roll back.
