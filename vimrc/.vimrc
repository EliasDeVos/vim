runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

"autocmd vimenter * NERDTree
let g:NERDTreeWinPos = "right"
let NERDTreeQuitOnOpen=1
let NERDTreeShowHidden=1
"let g:NERDTreeDirArrows=0
set encoding=utf-8
map <silent> <C-n> :NERDTreeToggle<CR>

let g:pdv_cfg_Author = "Elias De Vos <elias@codedor.be>"
let g:pdv_cfg_Since = strftime("%Y-%m-%d")
let g:pdv_cfg_Version = strftime("%Y-%m-%d")
nnoremap <C-K> :call PhpDocClass()<CR>
nnoremap <C-K> :call PhpDocSingle()<CR>


" make sure tmux and vim can use same nav keys
if exists('$TMUX')
  function! TmuxOrSplitSwitch(wincmd, tmuxdir)
    let previous_winnr = winnr()
    silent! execute "wincmd " . a:wincmd
    if previous_winnr == winnr()
      call system("tmux select-pane -" . a:tmuxdir)
      redraw!
    endif
  endfunction

  let previous_title = substitute(system("tmux display-message -p '#{pane_title}'"), '\n', '', '')
  let &t_ti = "\<Esc>]2;vim\<Esc>\\" . &t_ti
  let &t_te = "\<Esc>]2;". previous_title . "\<Esc>\\" . &t_te

  nnoremap <silent> <C-h> :call TmuxOrSplitSwitch('h', 'L')<cr>
  nnoremap <silent> <C-j> :call TmuxOrSplitSwitch('j', 'D')<cr>
  nnoremap <silent> <C-k> :call TmuxOrSplitSwitch('k', 'U')<cr>
  nnoremap <silent> <C-l> :call TmuxOrSplitSwitch('l', 'R')<cr>
else
  map <C-h> <C-w>h
  map <C-j> <C-w>j
  map <C-k> <C-w>k
  map <C-l> <C-w>l
endif

" shortcuts
" double o enters a new line in normal mode
"nmap oo o<Esc>
" ctrl + l adds a ; at the end of the line and goes to normal mode
"nmap <c-l> A;<ESC>

let g:solarized_termcolors=256
syntax enable
set background=dark
colorscheme solarized
"hi Directory guifg=#CCCCCC ctermfg=darkgrey

set laststatus=2
set number
set showcmd
set cursorline
set lazyredraw
set showmatch

set autoindent
set tabstop=4
set shiftwidth=4
set expandtab

set list listchars=eol:¬,tab:\▸\ ,extends:>,precedes:<

" Jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
