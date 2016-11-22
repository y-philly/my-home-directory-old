" _vimrc for vim(1)
"
" Yasuhiro SHIMIZU  <yasuhiro.phil81.gmail.com>
"

"" basic settings
"
set nobackup
set nowrap
set number
set ignorecase
set smartcase
set virtualedit=block
set history=10000
set undodir=~/var/vim/undo
syntax on " enable syntax


"" for NeoBundle
"
" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif

if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=~/.vim/bundle/neobundle.vim/

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

"" plugins
"
NeoBundle 'Shougo/unite.vim'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
