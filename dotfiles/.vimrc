" vim: foldmethod=marker

" Plugins {{{
set nocompatible
filetype off
" Automatically install vim-plug if it does not exist
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif
call plug#begin('~/.vim/plugged')

" Core {{{
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'godlygeek/tabular'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
"}}}

" Themes {{{
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'flazz/vim-colorschemes'
Plug 'w0ng/vim-hybrid'
"}}}

" Autocomplete {{{
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins'  }
  Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern', 'for': ['javascript', 'javascript.jsx'] }
else
  Plug 'Valloric/YouCompleteMe', { 'do': './install.py --tern-completer' }
endif
"}}}

" JavaScript {{{
Plug 'pangloss/vim-javascript'
Plug 'othree/es.next.syntax.vim'
Plug 'othree/javascript-libraries-syntax.vim'
"}}}

" ((Lisp)))) {{{
Plug 'guns/vim-clojure-static'
Plug 'guns/vim-clojure-highlight'
Plug 'guns/vim-sexp'
Plug 'tpope/vim-fireplace'
Plug 'tpope/vim-sexp-mappings-for-regular-people'
"}}}

call plug#end()
"}}}

" Core Settings {{{
filetype plugin indent on
set relativenumber
set ttimeoutlen=50
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set modeline
set ruler
set cursorline
set laststatus=2 " https://github.com/vim-airline/vim-airline#configuration
set incsearch
set ignorecase
set smartcase
set hlsearch

" Always copy to system clipboard with yank/delete
if has('clipboard')
  set clipboard=unnamedplus
endif

if has('nvim')
  let g:deoplete#enable_at_startup=1
  let g:SuperTabDefaultCompletionType="<c-n>"
  let g:deoplete#enable_refresh_always=1
  let g:tern_request_timeout=1
  let g:tern_show_signature_in_pum=0
  set completeopt-=preview
endif
"}}}

" Mappings {{{
let mapleader=" "

" http://statico.github.io/vim.html
" Move up/down through visual lines, not logical lines
nnoremap k gk
nnoremap j gj
nnoremap <Up> g<Up>
nnoremap <Down> g<Down>

nmap \q :nohlsearch<CR>
nnoremap <Leader>pt :NERDTreeToggle<CR>
nnoremap <C-T> :FZF<CR>
nnoremap <Leader>ff :FZF<CR>
"}}}

" Theming {{{
set t_Co=256
syntax enable
let g:airline_powerline_fonts=1
let g:rainbow_active=1

" Somebody teach me vimscript...
function! SetTheme(theme, light)
  if a:light
    set background=light
  else
    set background=dark
  endif
  let g:airline_theme='bubblegum'
  if a:theme == "solarized"
    let g:solarized_contrast='high'
    colorscheme solarized
    let g:airline_theme='solarized'
  elseif a:theme == "hybrid"
    colorscheme hybrid
  endif

  " Adjust rainbow parens color based on theme
  let rainbow_light = ['lightblue', 'lightyellow', 'red', 'darkgreen', 'darkyellow', 'lightred', 'yellow', 'cyan', 'magenta', 'white']
  let rainbow_dark = ['DarkBlue', 'Magenta', 'Black', 'Red', 'DarkGray', 'DarkGreen', 'DarkYellow']
  let g:rainbow_conf = {
  \   'ctermfgs': (&background=='light' ? rainbow_dark : rainbow_light)
  \}
endfunction

:call SetTheme('hybrid', 0)
"}}}
