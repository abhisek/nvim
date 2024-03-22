# Neovim Configuration

## Getting Started

Requirements:

* NodeJS
* `npm`

Clone the repository

```bash
git clone https://github.com/abhisek/nvim-config ~/.config/nvim
```

* Install the plugins by running `nvim` command: `PlugInstall`
* Install  CoC dependencies by running `./coc.sh`

## Things to Remember

| Function                    | Command                  |
|-----------------------------|--------------------------|
| Copy selection to clipboard | `"+y`                    |
| Copy buffer to clipboard    | `:w !pbcopy`             |
| Escape terminal mode        | `<c-\><c-n>`             |
| Line-break format select    | `v` to select, then `gq` |
| Restart `go` LSP            | `call go#lsp#Restart()`

## Troubleshooting

* Tree Sitter error with `invalid note type at position`. [Reference](https://github.com/nvim-treesitter/nvim-treesitter#i-get-query-error-invalid-node-type-at-position)

