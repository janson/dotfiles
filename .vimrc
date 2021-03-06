set nocompatible              " be iMproved, required
" -------------------------------------------------------------------
" Begin Plugins
" -------------------------------------------------------------------

" Use 'junegunn/vim-plug' for package management
call plug#begin('~/.vim/plugged')

" Fuzzy File Finding
" Let's try fzf for new goodness
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

" Navigation
Plug 'wincent/ferret' " Enhanced multi-file search via an :Ack command for searching across multiple files using The Silver Searcher 
Plug 'jeetsukumaran/vim-filebeagle' " similar to vim-vinegar, but avoids nasty netrw bug leaving buffers open

" Commands
Plug 'tomtom/tcomment_vim' " file-type sensible default comments
Plug 'ervandew/supertab' " tab-completion (code completion see YouCompleteMe)
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat' " allows vim-surround to be repeated with the . command
Plug 'moll/vim-bbye' " :Bdelete command that behaves like a well designed citizen
Plug 'janson/bufonly.vim' 

" UI Additions
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'kien/rainbow_parentheses.vim'

" Language Additions
"   Language pack
" Plug 'sheerun/vim-polyglot' " un-maintained as of 2017
"   Backend
Plug 'vim-ruby/vim-ruby'
Plug 'StanAngeloff/php.vim'
"   Middle
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
"   Front
Plug 'othree/html5.vim'
Plug 'Glench/Vim-Jinja2-Syntax' " for twig
"   Other
Plug 'elzr/vim-json'
Plug 'plasticboy/vim-markdown'
"   Lint
Plug 'w0rp/ale'
Plug 'editorconfig/editorconfig-vim'

" Color
Plug 'w0ng/vim-hybrid'
Plug 'lifepillar/vim-solarized8' " instead of 'official' @altercation
Plug 'arcticicestudio/nord-vim'

" Writing
"Plug 'reedes/vim-pencil'
"Plug 'reedes/vim-colors-pencil'
"Plug 'junegunn/goyo.vim'

" Add plugins to &runtimepath
call plug#end()

" -------------------------------------------------------------------
" Global VIM Settings (No Plugins Needed)
" -------------------------------------------------------------------
filetype on
syntax on
set ruler
set re=1 " use a non-broken regex engine
set encoding=utf-8

" ---------------------------------
" Whitespace stuff
" ---------------------------------
set tabstop=2
set softtabstop=2
set shiftwidth=2
set shiftround          " indents to the next multiple of 'shiftwidth'
set expandtab
set wrap
set linebreak           " don't wrap words
set textwidth=0         " don't break lines that are too long
set backspace=indent,eol,start		" allow backspacing over everying in insert
set autoindent          " always set autoindenting on
set clipboard+=unnamed  " yank to system clipboard

" ---------------------------------
" Searching
" ---------------------------------
set incsearch           " highlight while searching with / or ?
set ignorecase
set smartcase
set hlsearch            " keep matches highlighted
nmap <leader>q :nohlsearch<CR> " clear the highlight
set showcmd             " display incomplete commands
set showmatch           " show matching braces

" ---------------------------------
" Tab completion
" ---------------------------------
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc      " keep out source control & related
set wildignore+=*/tmp/*,*/cache/*,*.so,*.swp
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files

set iskeyword+=- " adds hyphen and en dash to list of characters considered _part_ of a word
set complete=.,w,b,u,t
set completeopt=longest,menuone,preview

" ---------------------------------
" History
" ---------------------------------
set history=500         " keep 500 lines of command line history
set autowrite           " write before hiding a buffer
set hidden              " retains state of unsaved buffer w/out writing to disk
set undolevels=1000     " 1000 undo levels
set noswapfile          " nah, I don't want a swap file

" ---------------------------------
" Bling
" ---------------------------------
set timeoutlen=250      " time to wait after ESC
set ttyfast             " faster redrawing
set lazyredraw          " only redraw when necessary
set cf                  " Enable error files & error jumping.
set wildmenu            " show other options for tab completion
set title               " sets terminal title
set visualbell          " visual indication instead of audible
set t_Co=256            " enable 256 colorschemes in non gui
set cursorline          " highlights current line, visually speaking
set list                        " show invisible chars
set listchars=tab:▸\ ,eol:¬     " add extra bling for tabs & end of lines
set termguicolors

" ---------------------------------
" Folding
" ---------------------------------
set foldmethod=indent       " why is syntax so unreliable?
set foldlevelstart=3
set foldignore=''           " default settings ignore '#' used in css

" ---------------------------------
" Bindings
" ---------------------------------
" Remap stupid Ex mode shortcut to repeat the last used macro. 
nmap Q @@

" rebind ESC to something a) more ergonomic b) not likely to be used
" can also use CTRL-[, which is built into vim
"inoremap jk <Esc>
"cnoremap jk <Esc>
"vnoremap jk <Esc>
" train the remapping, idea borrowed from
" http://learnvimscriptthehardway.stevelosh.com/chapters/10.html
"inoremap <esc> <nop>

" up-down by row, not line
nmap j gj
nmap k gk

" Command-][ to increase/decrease indentation
vmap <D-]> >gv
vmap <D-[> <gv

" Reformat JSON
nmap <Leader>j :%!python -m json.tool

" ---------------------------------
" File Types
" ---------------------------------
au BufRead,BufNewFile {Gemfile,Rakefile,Isolate,config.ru} set ft=ruby
au BufRead,BufNewFile {htaccess} set ft=apache
au BufRead,BufNewFile *.twig set ft=jinja.html

" Constraining columns in commit messages to 72 cols. 
" cref. https://chris.beams.io/posts/git-commit/
autocmd FileType gitcommit set textwidth=72
autocmd FileType gitcommit set colorcolumn=73

" ---------------------------------
" Writing
" ---------------------------------
"augroup pencil
  "autocmd!
  "autocmd FileType markdown,mkd,text call pencil#init()
  "colorscheme pencil
  "let g:airline_theme = 'pencil'
"augroup END

" -------------------------------------------------------------------
" Plugin Settings
" -------------------------------------------------------------------

" Fuzzy-find with fzf
nmap ; :Buffers<CR>
nmap <Leader>t :Files<CR>
nmap <Leader>r :Tags<CR>

" tcomment_vim
" leader-c  is the prefix for code related mappîngs 
" instead of `gc`
noremap <silent> <Leader>cc :TComment<CR>

" vim-bbye
noremap :BD :Bdelete

" vim-javascript
let javascript_enable_domhtmlcss=1

" vim-json
let g:vim_json_syntax_conceal = 0

" vim-markdown
let g:vim_markdown_initial_foldlevel=2

" netrw
"let g:netrw_liststyle = 3   " tree style listing
let g:netrw_liststyle = 1   " single list w/ detail

" file-beagle
let g:filebeagle_show_hidden = 1 " Show hidden and (wild-)ignored files by default (can be toggled when viewing a directory using 'gh').

" Powerline / Airline
set ttimeoutlen=10 " speed up delay when entering normal mode
set laststatus=2   " Always show the statusline

" Airline
let g:airline_skip_empty_sections = 1 " Do not draw separators for empty sections (only for the active window)
let g:airline_powerline_fonts = 0 " automatically populate g:airline_symbols with powerline symbols
"let g:airline_section_a = '' " defaults are: mode, crypt, paste, spell, iminsert
let g:airline_section_y = '' " defaults are: fileencoding, fileformat
let g:airline_section_warning = ''  " defaults are: ycm_warning_count, whitespace
let g:airline#extensions#tagbar#enabled = 0 " Disable airline tagbar for faster opening times

" Colorschemes
if !has('gui_running')
  "set background=dark
  " - modified solarized
  let g:solarized_term_italics = 1 " set to 1 to enable italics in the terminal (default is 0)
  let g:solarized_visibility = "low" " less in-yo-face invisible chars
  colorscheme solarized8_high
  " - nord (dark)
  "let g:nord_italic = 1
  "let g:nord_italic_comments = 1
  "colorscheme nord " all settings need to be set prior to scheme activation
endif
