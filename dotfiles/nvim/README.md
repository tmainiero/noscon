# Neovim Configuration

The configuration here should theoretically work in two ways:

* by copying over data over to `~/.config/nvim` and loading init.vim (currently untested)
* by loading the home manager neovim module.

## Notes

* **Dynamic Data**: Files in the `ultisnips` and `spell` directories should be regarded as "dynamic" data constantly in flux: especially when editing prose.
Because it is easy to forget to commit changes to these directories while editing a file, commit messages may not properly reflect when this directory was touched.
One possible re-organization would take involve a change in directory structure: move them to a "dynamic" subfolder of the dotfiles directory

* **VS Code** `init-vscode.vim` is intended to be loaded by the VScode plugin for neovim
