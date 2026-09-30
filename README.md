# dotfiles

My vim setup for writing Go and shell scripts. Plain Vim 8.2+, 
no plugins: everything here is built into Vim or the Go tool chain.

## Install

```bash
git clone https://github.com/arvindtyagicodes/dotfiles.git ~/dotfiles
~/dotfiles/install.sh

`install.sh` links `~/.vimrc` to this repo (this replaces existing
one, so back up yours first), creates the undo folder, and makes Caps
Lock and extra Esc on GNOME. Shift+Caps Lock is still Caps Lock.

Needs `go` on your PATH. For the system clipboard (`"+y`), install 
`vim-gtk3`.

## What's in the vimrc

- gofmt runs on every save of a `.go` file; on a syntax error the 
  file saves umformatted and the error shows in `:messages`
- `:make` runs `go build ./...` and fills the quickfix list
- `:make` and `:!` commands save the file first
- real tabs for Go, two spaces for shell scripts and YAML
- persistent undo, relative line numbers, smart-case search

## Shortcuts (leader is Space)

- `Space b` build; the error list opens only if there are errors
- `Space r` go run .
- `Space t` go test ./...
- `Space v` go vet ./...
- `Space n` / `Space p` next/previous error
- `Space c` close the error list
- `Space h` clear the search highlight
