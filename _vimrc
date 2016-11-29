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
set runtimepath+=~/vimfiles/bundle/neobundle.vim/

" Required:
call neobundle#begin(expand('~/vimfiles/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

"" plugins
"
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'cohama/agit.vim'
NeoBundle 'fuenor/im_control.vim'
NeoBundle 'houtsnip/vim-emacscommandline'
NeoBundle 'kana/vim-operator-user'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'osyo-manga/vim-marching'
NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'rhysd/clever-f.vim'
NeoBundle 'rhysd/vim-operator-surround'
NeoBundle 'thinca/vim-visualstar'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/vimfiler.vim'
NeoBundle 'Shougo/vimshell.vim'
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
if has("win64")
  set shell=cmd.exe
endif

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
" neocomplete
"
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
  \ 'default' : '',
  \ 'vimshell' : $HOME.'/.vimshell_hist',
  \ 'scheme' : $HOME.'/.gosh_completions'
    \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
" For no inserting <CR> key.
"return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
"let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

"
" neosnippet
"
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" My snippets directory
let g:neosnippet#snippets_directory = '~/snippets'

"
" unite
"
" prefix key.
nnoremap [unite] <Nop>
nmap <Space>f [unite]

" To track long mru history.
let g:unite_source_file_mru_long_limit = 10000
let g:unite_source_directory_mru_long_limit = 10000

" For optimize.
let g:unite_source_file_mru_filename_format = ''

" Start in insert mode.
let g:unite_enable_start_insert = 1

" Change default action.
" call unite#custom_default_action('source/bookmark/directory', 'vimfiler')
call unite#custom_default_action('source/bookmark/directory', 'lcd')

nnoremap <silent> [unite]b  :<C-u>Unite -buffer-name=bookmarks bookmark<CR>
nnoremap <silent> [unite]l  :<C-u>Unite -buffer-name=files buffer file_mru file<CR>
nnoremap <silent> [unite]o  :<C-u>Unite outline<CR>

autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()"{{{
  " Overwrite settings.
  imap <buffer> jj      <Plug>(unite_insert_leave)
endfunction"}}}

let g:unite_source_menu_menus = get(g:,'unite_source_menu_menus',{})

"
" VimFiler
"
noremap <Space>e :VimFilerCurrentDir<CR>
call vimfiler#custom#profile('default', 'context', {
\   'safe' : 0
\ })

"
" vim-operator-surround
"
map <silent>sa <Plug>(operator-surround-append)
map <silent>sd <Plug>(operator-surround-delete)
map <silent>sr <Plug>(operator-surround-replace)

"
" clever-f
"
let g:clever_f_smart_case = 1
let g:clever_f_use_migemo = 1

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

"
" im_control
"
inoremap <silent> <C-j> <C-^><C-r>=IMState('FixMode')<CR>

"
" marching.vim
"
let g:marching_clang_command = "C:/LLVM/bin/clang.exe"
let g:marching#clang_command#options = {
\   "c"   : "-std=c99",
\}
if has("win64")
let g:marching_include_paths = [
\   "C:/cygwin64/lib/gcc/x86_64-pc-cygwin/5.4.0/include/c++",
\   "C:/cygwin64/lib/gcc/x86_64-pc-cygwin/5.4.0/include/c++/x86_64-pc-cygwin",
\   "C:/cygwin64/lib/gcc/x86_64-pc-cygwin/5.4.0/include/c++/backward",
\   "C:/cygwin64/lib/gcc/x86_64-pc-cygwin/5.4.0/include",
\   "C:/cygwin64/lib/gcc/x86_64-pc-cygwin/5.4.0/include-fixed",
\   "C:/cygwin64/home/yasuhiro.shimizu/repositories/github/googletest/googletest/include",
\   "C:/cygwin64/home/yasuhiro.shimizu/repositories/github/googletest/googlemock/include",
\]
endif
let g:marching_enable_neocomplete = 1

if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'

set updatetime=200

imap <buffer> <C-x><C-o> <Plug>(marching_start_omni_complete)
imap <buffer> <C-x><C-x><C-o> <Plug>(marching_force_start_omni_complete)

"
" tagbar
"
let g:tagbar_sort = 0
let g:tagbar_left = 1
noremap <Space>l :Tagbar<CR>

"
" Solarized
"
let g:solarized_bold = 0
let g:solarized_underline = 1
let g:solarized_italic = 0
let g:solarized_contrast = "high"
let g:solarized_termtrans = 1
