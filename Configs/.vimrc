set number
nnoremap ; :
vnoremap ; :
nnoremap / /\c
vnoremap / /\c

call plug#begin()
Plug 'vim-airline/vim-airline'
Plug 'samoshkin/vim-mergetool'
Plug 'ap/vim-css-color'
Plug 'dylanaraps/wal.vim'
call plug#end()

nmap <leader>[ <plug>(MergetoolToggle)
nnoremap <silent> <leader>] :call mergetool#toggle_layout('mr,b')<CR>

let g:mergetool_prefer_revision = 'local'
let g:mergetool_layout = 'mr'

function s:on_mergetool_set_layout(split)
  if a:split["layout"] ==# 'mr,b' && a:split["split"] ==# 'b'
    set nodiff
    set syntax=on

  endif
endfunction

let g:MergetoolSetLayoutCallback = function('s:on_mergetool_set_layout')

nmap <expr> <C-Left> &diff? '<Plug>(MergetoolDiffExchangeLeft)' : '<C-Left>'
nmap <expr> <C-Right> &diff? '<Plug>(MergetoolDiffExchangeRight)' : '<C-Right>'
nmap <expr> <C-Down> &diff? '<Plug>(MergetoolDiffExchangeDown)' : '<C-Down>'
nmap <expr> <C-Up> &diff? '<Plug>(MergetoolDiffExchangeUp)' : '<C-Up>'

nmap <expr> <Up> &diff ? '[c' : '<Up>'
nmap <expr> <Down> &diff ? ']c' : '<Down>'

function s:QuitWindow()

  if get(g:, 'mergetool_in_merge_mode', 0)
    call mergetool#stop()
    return
  endif

  if &diff
    " Quit diff mode intelligently...
  endif

  quit
endfunction

command QuitWindow call s:QuitWindow()
nnoremap <silent> <leader>q :QuitWindow<CR>
