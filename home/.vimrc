set nocompatible              " be iMproved, required
" -------------------------------------------------------------------
" Begin Plugins
" -------------------------------------------------------------------

" Use 'junegunn/vim-plug' for package management
call plug#begin('~/.vim/plugged')

" Navigation
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim' " fuzzy file finding and finding in files
Plug 'jeetsukumaran/vim-filebeagle' " similar to vim-vinegar, but avoids nasty netrw bug leaving buffers open

" Commands
" Plug 'ervandew/supertab' " tab-completion (code completion see YouCompleteMe)
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat' " allows vim-surround to be repeated with the . command
Plug 'moll/vim-bbye' " :Bdelete command that behaves like a well designed citizen
Plug 'janson/bufonly.vim' 
Plug 'numToStr/Comment.nvim' " ⚡ Smart and Powerful commenting plugin for neovim ⚡

" UI Additions
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Language Additions
"   Language pack
" Plug 'sheerun/vim-polyglot' " un-maintained as of 2017
"   Backend
Plug 'elixir-editors/vim-elixir'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'smerrill/vcl-vim-plugin'
"   Middle
Plug 'pangloss/vim-javascript'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'leafgarland/typescript-vim'
Plug 'Quramy/vim-js-pretty-template'
Plug 'alampros/vim-styled-jsx' " 4 years old, but I haven't found anything to replace it — this repository has been archived by the owner. It is now read-only.
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'jparise/vim-graphql'
"   Front
Plug 'othree/html5.vim'
"   Other
Plug 'elzr/vim-json'
Plug 'plasticboy/vim-markdown'
Plug 'github/copilot.vim'
"   Lint
Plug 'w0rp/ale'
Plug 'editorconfig/editorconfig-vim'

" Color
Plug 'lifepillar/vim-solarized8', { 'branch': 'neovim' } " instead of 'official' @altercation
Plug 'gruvbox-community/gruvbox'
Plug 'nordtheme/vim'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'sainnhe/everforest'

" Writing
Plug 'preservim/vim-pencil' " og was reedes/vim-pencil
Plug 'preservim/vim-colors-pencil' " og was reedes/vim-colors-pencil
Plug 'junegunn/goyo.vim'

" Add plugins to &runtimepath
call plug#end()

" Initialize Comment.nvim (Somewhere after plug#end())
lua require('Comment').setup()

" -------------------------------------------------------------------
" Global VIM Settings (No Plugins Needed)
" -------------------------------------------------------------------
filetype on
syntax on
set ruler
"set re=1 " use a non-broken regex engine
set re=0 " using the old regex engine incurs major performance penalties, especially with typescript
set encoding=utf-8
set maxmempattern=2000 " (default 1000) sometimes we edit large files that choke standard 1MB pattern matching memory limits

" ---------------------------------
" Whitespace stuff
" ---------------------------------
set tabstop=2
set softtabstop=2
set shiftwidth=2
set shiftround          " indents to the next multiple of 'shiftwidth'
set expandtab
set wrap!               " opening up splits, etc, much easier with wrap off to start
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
set smartcase           " overrides ignorecase if your pattern contains mixed case
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
if (has("termguicolors"))
  set termguicolors       " add support for true color terminal if possible
endif

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
inoremap jk <Esc>
cnoremap jk <Esc>
vnoremap jk <Esc>
" train the remapping, idea borrowed from
" http://learnvimscriptthehardway.stevelosh.com/chapters/10.html
" note: this prevents the CTRL-[ keystroke, why still TBD
" inoremap <esc> <nop>

" up-down by row, not line
nmap j gj
nmap k gk

" Command-][ to increase/decrease indentation
vmap <D-]> >gv
vmap <D-[> <gv

" Reformat JSON
nmap <Leader>j :%!python3 -m json.tool

" Map <Leader>cc to toggle comments using comment.nvim
nmap <Leader>cc gcc
xmap <Leader>cc gc

" ---------------------------------
" File Types
" ---------------------------------
"au BufRead,BufNewFile {htaccess} set ft=apache
"au BufRead,BufNewFile *.twig set ft=jinja.html

" Constraining columns in commit messages to 72 cols. 
" cref. https://chris.beams.io/posts/git-commit/
autocmd FileType gitcommit set textwidth=72
autocmd FileType gitcommit set colorcolumn=73
autocmd FileType gitcommit set colorcolumn+=51 " In git commit messages, also colour the 51st column (for titles)

" sytax highlighting can get out of sync in large JSX & TSX files
" cref. https://thoughtbot.com/blog/modern-typescript-and-react-development-in-vim
autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

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

" copilot.vim
" This dynamically sets Copilot's Node command to whatever Node version is
" currently active in your global mise environment.
let g:copilot_node_command = trim(system('mise where node@22')) . '/bin/node'


" file-beagle
let g:filebeagle_suppress_keymaps = 1
map <silent> <Leader>d  <Plug>FileBeagleOpenCurrentWorkingDir
map <silent> -          <Plug>FileBeagleOpenCurrentBufferDir
let g:filebeagle_show_hidden = 1 " Show hidden and (wild-)ignored files by default (can be toggled when viewing a directory using 'gh').

" Fuzzy-find with fzf
nmap ; :Buffers<CR>
" Tell FZF to use RG - so we can skip .gitignore files even if not using
let $FZF_DEFAULT_COMMAND = 'rg --files'
" Augment Files command w/ the preview window
command! -bang -nargs=? -complete=dir Files
      \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
" find files
nmap <Leader>t :Files<CR>

" ------------
"  Note: can't for the life of me figure out how to just augment Rg itself, so
"  create a custom command and map _that_
" ------------
" Augment Rg command to search for word under cursor
" command! -bang -nargs=* CGrep
"   \ call fzf#vim#grep(
"   \   'rg '.shellescape(expand('<cword'>)),
"   \   fzf#vim#with_preview(), <bang>0)
" nnoremap <Leader>f :CGrep<CR>
" " command! -bang -nargs=* Rg
"   \ call fzf#vim#grep(
"   \   'rg --column --line-number --no-heading --color=always '.shellescape(expand('<cword>')), 1,
"   \   fzf#vim#with_preview(),
"   \   <bang>0)
" find word under cursor
"nnoremap <silent><Leader>f :Rg <C-r><C-w><CR>
" ------------

" fzf's results is in ugly popup instead of normal buffer
" Default fzf layout
" - Popup window
"let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
" - Down 40%
let g:fzf_layout = { 'down': '40%' }

" Customize fzf colors to match your color scheme
let g:fzf_colors =
      \ { 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'border':  ['fg', 'Ignore'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'] }

" netrw
"let g:netrw_liststyle = 3   " tree style listing
let g:netrw_liststyle = 1   " single list w/ detail

" vim-bbye
noremap :BD :Bdelete

" vim-javascript
let javascript_enable_domhtmlcss=1

" vim-json
let g:vim_json_syntax_conceal = 0

" vim-markdown
let g:vim_markdown_initial_foldlevel=2

" w0rp/ale
" The :ALEFixSuggest command will suggest some supported tools for fixing code.
let g:ale_fixers = {
\ 'javascript': ['prettier'],
\ 'typescript': ['prettier'],
\ 'typescriptreact': ['prettier', 'eslint'],
\ 'elixir': ['mix_format'],
\}
let g:ale_linters = {
\ 'javascript': ['eslint'],
\ 'typescript': ['eslint'],
\ 'typescriptreact': ['eslint'],
\ 'ruby': ['rubocop'],
\ 'scss': ['stylelint'],
\}
" Previously, from wf
" let g:ale_fixers = {
"   \    'javascript': ['eslint'],
"   \    'typescript': ['prettier', 'tslint'],
"   \    'vue': ['eslint'],
"   \    'scss': ['prettier'],
"   \    'html': ['prettier'],
"   \    'reason': ['refmt']
" \}
" let g:ale_linters = {
" \   'python': ['flake8', 'pylint'],
" \   'javascript': ['eslint'],
" \   'vue': ['eslint']
" \}
let g:ale_fix_on_save = 1 " Set this variable to 1 to fix files when you save them.
let g:ale_sign_error = '●' " Less aggressive than the default '>>'
let g:ale_sign_warning = '.'
let g:ale_lint_on_text_changed = 'never' " Let me finish writing the damn thing before you start complaining
let g:ale_lint_on_insert_leave = 0 " No really, let me finish!
let g:ale_lint_on_enter = 0 " Less distracting when opening a new file

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

" Set background based on OS mode at time of launch
" let theme = system('defaults read -g AppleInterfaceStyle')
"if theme =~ 'Dark'
  set background=dark
"else
  "set background=light
"endif

" Colorschemes
if !has('gui_running')
  " override escape chars for italics so we can get italicized text in
  " xterm-256
  set t_ZH=[3m
  set t_ZR=[23m
  " - modified solarized
  let g:solarized_term_italics = 1 " set to 1 to enable italics in the terminal (default is 0)
  let g:solarized_visibility = "low" " less in-yo-face invisible chars
  " - nord (dark)
  let g:nord_italic = 1
  let g:nord_italic_comments = 1
  "let g:nord_comment_brightness = 10 " deprecated cref https://github.com/arcticicestudio/nord-vim/issues/145
  " - gruvbox (vintage)
  let g:gruvbox_italic = 1
  " - everforest
  " This configuration option should be placed before `colorscheme everforest`.
  " Available values: 'hard', 'medium'(default), 'soft'
  let g:everforest_background = 'soft'
  " For better performance
  let g:everforest_better_performance = 1

  " all settings need to be set prior to scheme activation
  "colorscheme everforest
  "colorscheme solarized8_flat
  colorscheme solarized8_high
  "colorscheme nord 
  "colorscheme gruvbox 
endif
