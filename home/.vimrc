" Josh's .vimrc

set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

" file browser
Plugin 'scrooloose/nerdtree'

" fuzzy file,buffer,mru,tag,... finder
Plugin 'kien/ctrlp.vim'

" keyword completion cache
"Plugin 'Shougo/neocomplcache.vim'

" text surrounds
Plugin 'tpope/vim-surround'

Plugin 'plasticboy/vim-markdown'

Plugin 'majutsushi/tagbar'

" window zooming
Plugin 'vim-scripts/ZoomWin'

" status/tabline for vim
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" Git wrapper
Plugin 'tpope/vim-fugitive'
call vundle#end()
map <Leader>a :Git add %<CR>
map <Leader>s :Gstatus<CR>
map <Leader>c :Gcommit<CR>

" Ruby completion
Plugin 'vim-ruby/vim-ruby'

" wisely add end in ruby, endfunction/endif/more in vim script, etc
Plugin 'tpope/vim-endwise'

Plugin 'tomasr/molokai'
Plugin 'chankaward/vim-railscasts-theme'
Plugin 'zefei/cake16'

" http://vimcolors.com/54/Tomorrow-Night-Eighties/dark
Plugin 'chriskempson/vim-tomorrow-theme'

" a light colorscheme
Plugin 'Pychimp/vim-sol'
" light/pleasant colorscheme
Plugin 'jnurmine/Zenburn'

" turn off auto adding comments on next line
" so you can cut and paste reliably
" http://vimdoc.sourceforge.net/htmldoc/change.html#fo-table

set fo=tcq
filetype plugin on
set modeline
set modelines=1

syntax on

" set default comment color to cyan instead of darkblue
" which is not very legible on a black background
highlight comment ctermfg=cyan

"let g:neocomplcache_enable_at_startup = 1

map <Leader>= <C-w>=

set tabstop=2
set expandtab
set softtabstop=2
set shiftwidth=2
set number
set smartindent
set t_Co=256
set textwidth=140
au FileType gitcommit set tw=72

set formatoptions-=cro

autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" 80 column concern
"let &colorcolumn=join(range(81,999),",")
if version >= 703
  set colorcolumn=140
endif

if has('gui_running')
  colorscheme slate
  set guifont=terminal

  set guioptions=m
" Disable toolbar and menubar
"  set guioptions=-M

" http://www.dc.turkuamk.fi/docs/soft/vim/vim_gui.html
"set guioptions=r

" Only disable toolbar:
"  set guioptions=-T
endif

" nerdtree
map <leader>n :NERDTreeToggle<CR>
map <C-n> :NERDTreeToggle<CR>
" " autocmd vimenter * if !argc() | NERDTree | endif
"
" " colorscheme
color railscasts
syn on

highlight LiteralTabs ctermbg=darkgreen guibg=darkgreen
match LiteralTabs /\s\	/
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+$/

" Show me a ruler
set ruler

" switch panes easier
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

set splitbelow
set splitright

" Make Vim recognize XTerm escape sequences for Page and Arrow
" keys combined with modifiers such as Shift, Control, and Alt.
" See http://www.reddit.com/r/vim/comments/1a29vk/_/c8tze8p
if &term =~ '^screen'
  " Page keys http://sourceforge.net/p/tmux/tmux-code/ci/master/tree/FAQ
  execute "set t_kP=\e[5;*~"
  execute "set t_kN=\e[6;*~"

  " Arrow keys http://unix.stackexchange.com/a/34723
  execute "set <xUp>=\e[1;*A"
  execute "set <xDown>=\e[1;*B"
  execute "set <xRight>=\e[1;*C"
  execute "set <xLeft>=\e[1;*D"
endif

" neocomplcache keybindings
"let g:neocomplcache_enable_at_startup = 1

"inoremap <expr><C-g>     neocomplcache#undo_completion()
"inoremap <expr><C-l>     neocomplcache#complete_common_string()

" <CR>: close popup and save indent.
"inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
"function! s:my_cr_function()
"  return neocomplcache#smart_close_popup() . "\<CR>"
"  " For no inserting <CR> key.
"  "return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
"endfunction
"" <TAB>: completion.
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
"" <C-h>, <BS>: close popup and delete backword char.
"inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
"inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
"inoremap <expr><C-y>  neocomplcache#close_popup()
"inoremap <expr><C-e>  neocomplcache#cancel_popup()


""""""""""""""""""""""""""""""
" airline
""""""""""""""""""""""""""""""
let g:airline_theme             = 'powerlineish'
"let g:airline_enable_branch     = 1
"let g:airline_enable_syntastic  = 1
"let g:airline_powerline_fonts   = 1
"
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"
let g:airline#extensions#tabline#enabled = 1

" unicode symbols
let g:airline_left_sep = '»'
"let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
"let g:airline_right_sep = '◀'
"let g:airline_linecolumn_prefix = '␊ '
"let g:airline_linecolumn_prefix = '␤ '
"let g:airline_linecolumn_prefix = '¶ '
let g:airline#extensions#branch#symbol = '⎇ '
"let g:airline_paste_symbol = 'ρ'
"let g:airline_paste_symbol = 'Þ'
"let g:airline_paste_symbol = '∥'
let g:airline#extensions#whitespace#symbol = 'Ξ'

" Disable Markdown folding
let g:vim_markdown_folding_disabled=1

" Always show the airline bar
set laststatus=2
set rtp+=~/.vim/bundle/Vundle.vim
Plugin 'gmarik/Vundle.vim'
