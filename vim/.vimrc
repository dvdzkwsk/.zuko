set t_Co=256

" =====================================
" Vundle (Package Manager)
" =====================================
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" =============================
" Vundle Plugins
" =============================
Plugin 'VundleVim/Vundle.vim'

" File System
" --------------------------
Plugin 'scrooloose/nerdtree'

" Theming
" ---------------------------
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'godlygeek/tabular'
Plugin 'flazz/vim-colorschemes'
Plugin 'morhetz/gruvbox'

" General Tools
" ---------------------------
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'

" Git
" ---------------------------
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'

" AutoComplete
" ---------------------------
Plugin 'ervandew/supertab'
if has('nvim')
  Plugin 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins'  }
  Plugin 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern', 'for': ['javascript', 'javascript.jsx'] }
else
  Plugin 'Valloric/YouCompleteMe', { 'do': './install.py --tern-completer' }
endif

" JavaScript
" ---------------------------
Plugin 'scrooloose/syntastic'
Plugin 'pangloss/vim-javascript'
Plugin 'othree/yajs.vim', { 'for': ['javascript', 'javascript.jsx'] }
Plugin 'othree/es.next.syntax.vim', { 'for': ['javascript', 'javascript.jsx'] }
Plugin 'mxw/vim-jsx', { 'for': ['javascript', 'javascript.jsx'] }
Plugin 'othree/javascript-libraries-syntax.vim', { 'for': ['javascript', 'javascript.jsx'] }
Plugin 'flowtype/vim-flow', { 'for': ['javascript', 'javascript.jsx'] }

" Lisp
" ---------------------------
Plugin 'guns/vim-sexp'
Plugin 'luochen1990/rainbow'

" =====================================
" General
" =====================================
" autocmd VimEnter * NERDTree "Automatically open NERDTree on start
set ttimeoutlen=50

" =====================================
" Spacing
" =====================================
set tabstop=2
set shiftwidth=2
set expandtab

" =====================================
" Custom Hotkeys
" =====================================
" Toggle Nerdtree Open/Close
map <C-n> :NERDTreeToggle<CR>

" Multi cursor mappings
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_next_key='<C-d>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

" =====================================
" End Vundle
" =====================================
call vundle#end()
filetype plugin indent on

" =====================================
" Theming
" =====================================
syntax enable
set number
set ruler
set cursorline
set laststatus=2 " https://github.com/vim-airline/vim-airline#configuration
let g:rainbow_active=1

" This is needed as a fallback when the terminal is not using
" the solarized color scheme itself.
" let g:solarized_termcolors=256
colorscheme solarized
set background=dark
let g:airline_theme='solarized'

" Color scheme override when I don't feel like using solarized
" as my default terminal theme.
"colorscheme gruvbox
"set background=dark
"let g:airline_theme='gruvbox'
"let g:gruvbox_contrast_dark='medium'
"let g:gruvbox_contrast_light='hard'

" Fix arrows in airline status bar. If they are not working, make sure this
" is enabled and that your terminal is configured to use a patched powerline
" font for non-ascii characters. See: https://github.com/powerline/fonts
let g:airline_powerline_fonts=1

" =====================================
" Autocomplete / Search
" =====================================
nnoremap <C-T> :FZF<CR>
inoremap <C-T> <ESC>:FZF<CR>i

if has('nvim')
  let g:deoplete#enable_at_startup=1
  let g:SuperTabDefaultCompletionType="<c-n>"
  let g:tern_request_timeout=1
  let g:tern_show_signature_in_pum=0
  set completeopt-=preview
endif

" =====================================
" JavaScript
" =====================================
let g:flow#enable=0
let g:flow#autoclose=1
