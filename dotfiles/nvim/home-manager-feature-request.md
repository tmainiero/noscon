# Feature request: Control plugin config load order in neovim module

## Problem

The home-manager neovim module always appends plugin `config` blocks **after**
`extraConfig` in the generated init file. There is no way to make a plugin's
config load before `extraConfig`.

This causes a silent race condition with ftplugin-based plugins in neovim 0.11+.

## How neovim 0.11 changed things

Neovim 0.11 triggers ftplugin-based plugin initialization during `init.lua`'s
`vim.cmd [[source ...]]` call — i.e., during `extraConfig` execution. Plugins
like vimtex, ale, and ultisnips detect filetypes and read their `g:` config
variables at this point. Since plugin `config` blocks haven't executed yet,
the variables don't exist, and the plugins silently fall back to defaults.

## Minimal reproducible example

```nix
programs.neovim = {
  extraConfig = ''
    echom "extraConfig runs"
  '';
  plugins = [
    {
      plugin = pkgs.vimPlugins.vimtex;
      config = ''
        echom "vimtex config runs"
        let g:vimtex_compiler_latexmk = { 'continuous': 0 }
      '';
    }
  ];
};
```

Open neovim and run `:messages`. Output:

```
extraConfig runs
vimtex config runs
```

The `config` block always runs after `extraConfig`. If `extraConfig` contains
`filetype plugin on` (or if neovim's defaults trigger filetype detection),
vimtex initializes during `extraConfig` — before its `g:` variables are set.

## Real-world impact

With the above config, opening a `.tex` file:

```vim
:echo b:vimtex.compiler.continuous
" Returns 1 (vimtex default), NOT 0 (user setting)
```

The `g:vimtex_compiler_latexmk` setting is completely ignored because vimtex's
ftplugin already initialized with defaults during `extraConfig`.

Other affected settings: `g:vimtex_view_method`, `g:vimtex_syntax_conceal_disable`,
`g:vimtex_imaps_leader`, `g:ale_set_signs`, `g:UltiSnipsSnippetDirectories`, etc.

## Proposed solutions

Any of the following would fix this:

1. **`earlyConfig` field**: A new field on plugin attrsets that loads before
   `extraConfig`. This is the most targeted fix.

2. **`priority` field**: A numeric priority on plugin config blocks, allowing
   users to control relative ordering.

3. **Change default order**: Load plugin `config` blocks before `extraConfig`
   instead of after. This may break existing configs that depend on the current
   order, so it would need a migration path.

## Current workaround

We avoid home-manager's `{plugin, config}` attrsets entirely and instead
concatenate plugin configs into `extraConfig` manually. See
`home-modules/neovim/default.nix` in this repo for the implementation.
