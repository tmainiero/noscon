# Neovim Lua Migration Plan

## Why this exists

Home-manager's neovim module appends plugin `config` blocks **after** `extraConfig`
in the generated init file. In neovim 0.11+, ftplugin-based plugins (vimtex, ale,
ultisnips) initialize during `extraConfig`'s source call — before plugin configs
execute. This means `g:` variables set in plugin config blocks are silently ignored.

The current workaround concatenates all plugin configs into `extraConfig` so they
run first (see `home-modules/neovim/default.nix`). This works but is a nix-level
hack around a load-order problem that Lua `init` callbacks would solve natively.

## Migration path

With Lua-based plugin management (e.g. lazy.nvim or native `vim.g` in init.lua),
each plugin's config runs in its `init` or `config` callback — no dependency on
home-manager's ordering. The nix workaround can be removed entirely.

## Checklist

- [ ] Convert `dotfiles/nvim/plugin/*.vim` configs to Lua equivalents
  - [ ] `vimtex-config.vim` → `vim.g.vimtex_*` assignments
  - [ ] `ale-config.vim` → `vim.g.ale_*` assignments
  - [ ] `ultisnips-config.vim` → `vim.g.UltiSnips*` assignments
  - [ ] `ayu-vim-config.vim` → Lua colorscheme setup
  - [ ] `vim-airline-config.vim` → Lua statusline config (or switch to lualine)
  - [ ] `vim-cool-config.vim` → Lua equivalent
  - [ ] `auto-pairs-config.vim` → nvim-autopairs Lua config
  - [ ] `vim-surround-config.vim` → nvim-surround Lua config
  - [ ] `vim-sneak-config.vim` → leap.nvim or flash.nvim Lua config
  - [ ] `fzf-vim-config.vim` → telescope.nvim Lua config
- [ ] Convert `dotfiles/nvim/my-config/*.vim` to Lua
  - [ ] `settings.vim` → `vim.opt.*` assignments
  - [ ] `keybindings.vim` → `vim.keymap.set` calls
  - [ ] `functions.vim` → Lua functions
  - [ ] `plugin-keybindings.vim` → Lua keymaps
- [ ] Switch `home-modules/neovim/default.nix` back to using home-manager's
      `{plugin, config}` attrsets (or use lazy.nvim for plugin management)
- [ ] Remove the `pluginDefs`/`normalize`/`plugin-configs` workaround from default.nix
- [ ] Test all plugins load correctly with `:checkhealth`
