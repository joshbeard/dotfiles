" Josh's .vimrc

" ---- Common Settings ---------------------------------------------------------
set nocompatible
filetype off
filetype plugin on
filetype plugin indent on
syntax on

let mapleader = ","

" turn off auto adding comments on next line
" so you can cut and paste reliably
" http://vimdoc.sourceforge.net/htmldoc/change.html#fo-table
set fo=tcq
"set formatoptions-=cro
set formatoptions-=qrn1
set modeline
set modelines=1

set tabstop=2
set expandtab
set softtabstop=2
set shiftwidth=2
set wrap
set number
set ruler
set smartindent
set t_Co=256
set textwidth=79
"set textwidth=140
set foldmethod=indent
set foldlevelstart=99

" Show invisible characters (e.g. tabs) with special characters
set list
"set listchars=tab:▸\ ,eol:¬
set listchars=tab:▸\ 

" Search casing
" all-lowercase will be case-insensitive; mixed characters are case-sensitive.
set ignorecase
set smartcase

" Highlight search results
set incsearch
set showmatch
set hlsearch

" apply substitutions globally by default
set gdefault

" Always show the status bar
set laststatus=2

set splitbelow
set splitright

" The status bar shows the mode (insert, visual, etc)
set noshowmode

set clipboard=unnamed

au FileType gitcommit set tw=72

autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Place markers at 80 and 140 character columns
set colorcolumn=80,140
" The following line blocks out all columns after the first value
"let &colorcolumn=join(range(81,999),",")

" ---- Plugins -----------------------------------------------------------------

" Vundle plugin manager
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

" nerdtree file browser (<leader> n)
Plugin 'scrooloose/nerdtree'
" nerdtree plugin for git status
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'jistr/vim-nerdtree-tabs'

" highlights open files; close buffer from nerdtree
"Plugin 'PhilRunninger/nerdtree-buffer-ops'
" fuzzy file,buffer,mru,tag,... finder
"Plugin 'kien/ctrlp.vim'

" keyword completion cache
"Plugin 'Shougo/neocomplcache.vim'

" text surrounds
Plugin 'tpope/vim-surround'

Plugin 'godlygeek/tabular'

Plugin 'preservim/vim-markdown'

" Code outline. Requires 'ctags' system package
Plugin 'preservim/tagbar'

" window zooming
Plugin 'vim-scripts/ZoomWin'

" Status bar
" https://github.com/itchyny/lightline.vim
Plugin 'itchyny/lightline.vim'

" comment functions
Plugin 'preservim/nerdcommenter'

" Git wrapper
Plugin 'tpope/vim-fugitive'

" Ruby completion
"Plugin 'vim-ruby/vim-ruby'

" wisely add end in ruby, endfunction/endif/more in vim script, etc
"Plugin 'tpope/vim-endwise'

" Color schemes
"Plugin 'tomasr/molokai'
"Plugin 'chankaward/vim-railscasts-theme'
"Plugin 'zefei/cake16'
"Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'
Plugin 'NLKNguyen/papercolor-theme'
"Plugin 'sainnhe/everforest'
" This requires 'termguicolors'
"Plugin 'bluz71/vim-nightfly-guicolors'

" http://vimcolors.com/54/Tomorrow-Night-Eighties/dark
"Plugin 'chriskempson/vim-tomorrow-theme'

" Transparent background
Plugin 'tribela/vim-transparent'

" a light colorscheme
" Plugin 'Pychimp/vim-sol'
" light/pleasant colorscheme
" Plugin 'jnurmine/Zenburn'

" Display lines at indentation levels
" Plugin 'Yggdroot/indentLine.git'

Plugin 'vim-syntastic/syntastic'

" Fold improvements
" FIXME: serious lag with this enabled
"Plugin 'tmhedberg/SimpylFold'

" Python
Plugin 'vim-python/python-syntax'
Plugin 'vim-scripts/indentpython.vim'
"Plugin 'nvie/vim-flake8'

Plugin 'vim-scripts/YankRing.vim'

call vundle#end()

" ---- Styling -----------------------------------------------------------------
if has('gui_running')
  colorscheme slate
  set guifont=terminal
  " http://www.dc.turkuamk.fi/docs/soft/vim/vim_gui.html
  set guioptions=m
else
  " colorscheme
  "colorscheme railscasts
  " colorscheme zenburn
  set background=dark
  colorscheme PaperColor
endif

"autocmd highlight LiteralTabs ctermbg=red guibg=red
"match LiteralTabs /\s\	/
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" Column marker colors
"autocmd ColorScheme * hi ColorColumn ctermbg=darkgreen guibg=lightgrey
autocmd ColorScheme * hi ColorColumn ctermbg=101 guibg=lightgrey

" This could perform poorly.
" See https://github.com/vim-python/python-syntax for configuration.
let python_highlight_all=0

" Comment color
"autocmd ColorScheme * highlight comment ctermfg=cyan

" Show docstring on folds
let g:SimpylFold_docstring_preview=1

"Plugin 'vimwiki/vimwiki'
"let g:vimwiki_list = [{'path': '~/notes', 'syntax': 'markdown', 'ext': '.md'}]

" Files to ignore in NERDTree
let NERDTreeIgnore=['\.pyc$', '\~$']

" ---- Markdown settings -------------------------------------------------------
" Disable Markdown folding
"let g:vim_markdown_folding_disabled = 1
" Don't conceal markdown syntax
let g:vim_markdown_conceal = 0
" Don't conceal markdown syntax for code blocks
let g:vim_markdown_conceal_code_blocks = 0
" Map filetypes to fenced code block names
let g:vim_markdown_fenced_languages = ['c++=cpp', 'viml=vim', 'bash=sh', 'ini=dosini']
" Highlight YAML front matter as used by Jekyll or Hugo.
let g:vim_markdown_frontmatter = 1
" Indent lists by 2 spaces by default
let g:vim_markdown_new_list_item_indent = 2
" Don't auto-add bullet points
let g:vim_markdown_auto_insert_bullets = 0

" ---- Mappings ----------------------------------------------------------------
map <Leader>a :Git add %<CR>
map <Leader>s :Gstatus<CR>
map <Leader>c :Gcommit<CR>
map <Leader>= <C-w>=

" clear search
nnoremap <leader><space> :noh<cr>

" Press tab to jump between matching bracket pairs
nnoremap <tab> %
vnoremap <tab> %

" Exit back to normal mode by typing 'jj' twice
" inoremap jj <ESC>

" Navigate by screen line instead of file line (wrapped long lines)
nnoremap j gj
nnoremap k gk

" Make ; act like :
nnoremap ; :

" <leader>v to select text that was just pasted
nnoremap <leader>v V`]

" edit vimrc on the fly
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>


" nerdtree
map <leader>n :NERDTreeToggle<CR>
map <C-n> :NERDTreeToggle<CR>

" switch panes easier
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Open vertical split and switch to it
nnoremap <leader>w <C-w>v<C-w>l

" Enable folding with the spacebar
nnoremap <space> za

" Disable Vim's regex pattern
nnoremap / /\v
vnoremap / /\v

" Toggle scheme backgrounds (dark/light)
call togglebg#map("<F5>")

" Show tagbar
nmap <F8> :TagbarToggle<CR>

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

" ---- File settings -----------------------------------------------------------
au BufNewFile,BufRead *.js, *.html, *.css, *.rb
  \set tabstop=2
  \set softtabstop=2
  \set shiftwidth=2
  \set fileformat=unix

" Python
au BufNewFile,BufRead *.py
  \set tabstop=4
  \set softtabstop=4
  \set shiftwidth=4
  \set textwidth=79
  \set expandtab
  \set autoindent
  \set fileformat=unix

au BufNewFile,BufRead *.go
  \set tabstop=4
  \set softtabstop=4
  \set shiftwidth=4
  \set textwidth=79
  \set expandtab
  \set autoindent
  \set fileformat=unix

