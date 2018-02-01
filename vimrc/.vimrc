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

" switch vim to paste mode when copying file
function! WrapForTmux(s)
  if !exists('$TMUX')
    return a:s
  endif

  let tmux_start = "\<Esc>Ptmux;"
  let tmux_end = "\<Esc>\\"

  return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
endfunction

let &t_SI .= WrapForTmux("\<Esc>[?2004h")
let &t_EI .= WrapForTmux("\<Esc>[?2004l")

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

"custom status line in vim
set ruler
set rulerformat=%55(%{strftime('%a\ %b\ %e\ %I:%M\ %p')}\ %5l,%-6(%c%V%)\ %P%)
" first, enable status line always
set laststatus=2

" change tab size for php ad vue files
autocmd FileType vue setlocal shiftwidth=2 tabstop=2
autocmd FileType js setlocal shiftwidth=2 tabstop=2
autocmd FileType php setlocal shiftwidth=4 tabstop=4

" now set it up to change the status line based on mode
if version >= 700
  au InsertEnter * hi StatusLine term=reverse ctermbg=240 ctermfg=220 gui=undercurl guisp=Magenta
  au InsertLeave * hi StatusLine term=reverse ctermfg=118 ctermbg=20  gui=bold,reverse
endif

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

set relativenumber

" Jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
