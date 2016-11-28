" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif

" Don't load another plugin for this buffer
let b:did_ftplugin = 1

setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal expandtab
setlocal foldmethod=indent
setlocal commentstring=#%s

let g:syntastic_python_checkers = ["flake8"]

setlocal omnifunc=jedi#completions
