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
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

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
Plugin 'othree/yajs.vim'
Plugin 'othree/es.next.syntax.vim'
Plugin 'mxw/vim-jsx'
Plugin 'othree/javascript-libraries-syntax.vim'

if has('nvim')
  Plugin 'neomake/neomake'
else
  Plugin 'scrooloose/syntastic'
endif

" Clojure
" ---------------------------
Plugin 'luochen1990/rainbow'
Plugin 'guns/vim-clojure-static'
Plugin 'guns/vim-clojure-highlight'
Plugin 'guns/vim-sexp'
Plugin 'tpope/vim-fireplace'
Plugin 'tpope/vim-sexp-mappings-for-regular-people'

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
set background="dark"
let use_solarized=1

syntax enable
set number
set ruler
set cursorline
set laststatus=2 " https://github.com/vim-airline/vim-airline#configuration

if use_solarized
  let g:solarized_contrast='high'
  colorscheme solarized
  let g:airline_theme='solarized'
else
  colorscheme gruvbox
  let g:airline_theme='gruvbox'
  let g:gruvbox_contrast_dark='medium'
  let g:gruvbox_contrast_light='hard'
endif

" Fix arrows in airline status bar. If they are not working, make sure this
" is enabled and that your terminal is configured to use a patched powerline
" font for non-ascii characters. See: https://github.com/powerline/fonts
let g:airline_powerline_fonts=1
" let g:airline#extensions#tabline#enabled=1     " Enable the list of buffers
" let g:airline#extensions#tabline#fnamemod=':t' " Show just the filename

" =====================================
" JavaScript
" =====================================
function! StrTrim(txt)
  return substitute(a:txt, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')
endfunction

let g:jsx_ext_required = 0
let g:flow_path = StrTrim(system('PATH=$(npm bin):$PATH && which flow'))
let g:flow#enable=0
let g:flow#autoclose=1

if has('nvim')
  let g:deoplete#sources#flow#flow_bin = g:flow_path
  let g:neomake_jsx_flow_exe = g:flow_path
  let g:neomake_javascript_flow_exe = g:flow_path
  let g:neomake_javascript_enabled_makers = ['eslint']
  let g:neomake_jsx_enabled_makers = ['eslint']
endif

" =====================================
" Clojure
" =====================================
let g:paredit_mode=0

" Rainbow Parentheses
" -----------------------------
let g:rainbow_active=1
let lightcolors =  ['lightblue', 'lightyellow', 'red', 'darkgreen', 'darkyellow', 'lightred', 'yellow', 'cyan', 'magenta', 'white']
let darkcolors = ['DarkBlue', 'Magenta', 'Black', 'Red', 'DarkGray', 'DarkGreen', 'DarkYellow']
let g:rainbow_conf = {
\   'ctermfgs': (&background=="light"? darkcolors : lightcolors)
\}

" =====================================
" Autocomplete + Search
" =====================================
nnoremap <C-T> :FZF<CR>
inoremap <C-T> <ESC>:FZF<CR>i

if has('nvim')
  let g:deoplete#enable_at_startup=1
  let g:SuperTabDefaultCompletionType="<c-n>"
  let g:deoplete#enable_refresh_always=1
  let g:tern_request_timeout=1
  let g:tern_show_signature_in_pum=0
  set completeopt-=preview

  let g:neomake_warning_sign = {
  \ 'text': 'W',
  \ 'texthl': 'WarningMsg',
  \ }
  let g:neomake_error_sign = {
  \ 'text': 'E',
  \ 'texthl': 'ErrorMsg',
  \ }

  autocmd! BufWritePost * Neomake
endif
