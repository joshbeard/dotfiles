set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/

call vundle#rc()

" let Vundle manage Vundle
" " required!
Bundle 'gmarik/vundle'
Bundle 'scrooloose/nerdtree'
Bundle 'jnurmine/Zenburn'
Bundle 'godlygeek/tabular'
Bundle 'kien/ctrlp.vim'
Bundle 'Shougo/neocomplcache.vim'
Bundle 'tpope/vim-surround'
Bundle 'majutsushi/tagbar'
Bundle 'vim-scripts/ZoomWin'
Bundle 'rodjek/vim-puppet'
Bundle 'bling/vim-airline'
Bundle 'scrooloose/syntastic'
Bundle 'Pychimp/vim-sol'

" turn off auto adding comments on next line
" so you can cut and paste reliably
" http://vimdoc.sourceforge.net/htmldoc/change.html#fo-table
set fo=tcq
set modeline

syntax on

" set default comment color to cyan instead of darkblue
" which is not very legible on a black background
highlight comment ctermfg=cyan

let g:neocomplcache_enable_at_startup = 1

map <Leader>= <C-w>=

set tabstop=2
set expandtab
set softtabstop=2
set shiftwidth=2
set number
set smartindent
set t_Co=256

set formatoptions-=cro

autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" 80 column concern
"let &colorcolumn=join(range(81,999),",")
if version >= 703
  set colorcolumn=80
endif

" nerdtree
map <leader>n :NERDTreeToggle<CR>
" " autocmd vimenter * if !argc() | NERDTree | endif
"
" " colorscheme
color zenburn
syn on

highlight LiteralTabs ctermbg=darkgreen guibg=darkgreen
match LiteralTabs /\s\	/
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+$/

" Show me a ruler
set ruler

" Set up puppet manifest and spec options
au BufRead,BufNewFile *.pp
  \ set filetype=puppet
au BufRead,BufNewFile *_spec.rb
  \ nmap <F8> :!rspec --color %<CR>

" Enable indentation matching for =>'s
filetype plugin indent on


nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

set splitbelow
set splitright

" neocomplcache keybindings
let g:neocomplcache_enable_at_startup = 1

inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()


""""""""""""""""""""""""""""""
" airline
""""""""""""""""""""""""""""""
"let g:airline_theme             = 'powerlineish'
let g:airline_enable_branch     = 1
let g:airline_enable_syntastic  = 1
let g:airline_powerline_fonts   = 1

" Always show the airline bar
set laststatus=2
