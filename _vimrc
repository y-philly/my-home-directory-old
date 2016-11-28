" _vimrc for vim(1)
"
" Yasuhiro SHIMIZU  <yasuhiro.phil81.gmail.com>
"

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
NeoBundle 'houtsnip/vim-emacscommandline'
NeoBundle 'kana/vim-operator-user'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'rhysd/clever-f.vim'
NeoBundle 'rhysd/vim-operator-surround'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler.vim'
NeoBundle 'tpope/vim-fugitive'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

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
syntax on
set backspace=indent,eol,start

"" spell check
"
set spelllang+=cjk
set spell

"" show space characters
"
set list
set listchars=tab:>-,trail:-,extends:>,precedes:<,nbsp:%

"" cscope
"
if has("cscope")
  set csto=0
  set cscopetag
  set cscopequickfix=s-,c-,d-,i-,t-,e-
  set nocscopeverbose
  " add any database in current directory
  if filereadable("cscope.out")
      cscope add cscope.out
  " else add database pointed to by environment
  elseif $CSCOPE_DB != ""
      cscope add $CSCOPE_DB
  endif
  set cscopeverbose
endif
function GenCscopeOut()
  cscope kill -1
  make cscope
  cscope add cscope.out
endfunction

"" quickfix
"
autocmd QuickFixCmdPost make,vimgrep,cscope if len(getqflist()) != 0 | copen | endif

"" status line
"
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}][TYPE=%Y][ASCII=0x\%02.2B][POS=%l,%v][%p%%]%{fugitive#statusline()}
set laststatus=2

"" remove unnecessary space
"
autocmd BufWritePre * :%s/\s\+$//ge

"" key mapping
"
noremap <C-N> :cn<CR>
noremap <C-P> :cp<CR>
noremap <Space>t :tabnew<CR>
noremap! <C-H> <Backspace>

"" plugin settings
"
" VimFiler
"
noremap <Space>e :VimFilerCurrentDir<CR>
"
" vim-operator-surround
"
map <silent>sa <Plug>(operator-surround-append)
map <silent>sd <Plug>(operator-surround-delete)
map <silent>sr <Plug>(operator-surround-replace)
"
" vim-easy-motion
"
let g:EasyMotion_do_mapping = 0 " Disable default mappings
let g:EasyMotion_use_migemo = 1

" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap s <Plug>(easymotion-s2)

" Turn on case sensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
