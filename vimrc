" ---------- General ----------
syntax on
filetype plugin indent on

set number relativenumber   " absolute line under cursor, relative elsewhere
set incsearch hlsearch      " live search + highlight matches
set ignorecase smartcase    " case-insensitive unless you type a capital
set hidden                  " switch buffers without forced :w
set wildmenu                " visual menu for :e, :b tab-completion
set path+=**                " :find searches subdirectories
set scrolloff=5             " keep 5 lines visible around cursor
set laststatus=2            " always show statusline
set backspace=indent,eol,start

" A ~/.vimrc makes Vim skip defaults.vim, so these stay off unless set here
set showcmd                 " show half-typed commands (d2, ci...) bottom right
set ruler                   " line,col in the statusline
set ttimeout ttimeoutlen=50 " Esc leaves Insert mode instantly in a terminal

set autowrite               " :make, :!cmd and Ctrl=z save the file first
set undofile undodir=~/.vim/undo   "undo survives restarts (mkdir -p ~/.vim/undo) 

" ---------- Go specific ----------
augroup golang
  autocmd!
  " Go convention: real tabs, displayed 4 wide
  autocmd FileType go setlocal noexpandtab tabstop=4 shiftwidth=4

  " :make runs go build on the whole module, errors -> quickfix
  autocmd FileType go setlocal makeprg=go\ build\ ./...
  autocmd FileType go setlocal errorformat=%f:%l:%c:\ %m,%f:%l:\ %m

  " Run gofmt on save; keeps cursor position, errors -> quickfix
  autocmd BufWritePre *.go call GoFmt()
augroup END

"----------- Shell scripts and YAML ----------
augroup scripts
  autocmd!
  autocmd FileType sh,yaml setlocal expandtab tabstop=2 shiftwidth=2
augroup END

" gofmt on save. The buffer is only touched when gofmt succeeds AND changes
" something, so undo history, marks and g; stay clean. On a syntax error the
" file saves unformatted; the message stays in :messages and <Space>b shows it.
function! GoFmt() abort
  let l:save = winsaveview()
  let l:out = systemlist('gofmt', getline(1,'$'))
  if v:shell_error
    echohl ErrorMsg | echomsg 'gofmt: ' .get(l:out, 0, 'syntax error') | echohl None
  elseif l:out !=# getline(1, "$")
     silent! %delete _
     call setline(1, l:out)
  endif
  call winrestview(l:save)
endfunction

" ---------- Convenience mappings ----------
let mapleader = " "
" build quietly; the error list opens only when there are errors
nnoremap <leader>b :silent make<bar>redraw!<bar>cwindow<bar>echo len(getqflist()) ? 'build failed' : 'build OK'<CR>
nnoremap <leader>t :!go test ./...<CR>
nnoremap <leader>v :!go vet ./...<CR>
nnoremap <leader>r :!go run .<CR>
nnoremap <leader>n :cnext<CR>
nnoremap <leader>p :cprev<CR>
nnoremap <leader>c :cclose<CR>
nnoremap <leader>h :nohlsearch<CR>
