set t_Co=256
set nocompatible
filetype off

" =============================
" < Plugins >
" =============================
call plug#begin('~/.vim/plugged')

" Editor Basics
" --------------------------
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'neomake/neomake'

" Theming
" ---------------------------
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'godlygeek/tabular'
Plug 'flazz/vim-colorschemes'
Plug 'jnurmine/Zenburn'
Plug 'zeis/vim-kolor'

" Git
" ---------------------------
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" AutoComplete
" ---------------------------
Plug 'ervandew/supertab'
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins'  }
  Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern', 'for': ['javascript', 'javascript.jsx'] }
else
  Plug 'Valloric/YouCompleteMe', { 'do': './install.py --tern-completer' }
endif

" JavaScript
" ---------------------------
Plug 'pangloss/vim-javascript'
Plug 'othree/es.next.syntax.vim'
Plug 'othree/javascript-libraries-syntax.vim'

" Lisp
" ---------------------------
Plug 'guns/vim-clojure-static'
Plug 'guns/vim-clojure-highlight'
Plug 'guns/vim-sexp'
Plug 'tpope/vim-fireplace'
Plug 'tpope/vim-sexp-mappings-for-regular-people'

call plug#end()

" =====================================
" Editor Basics
" =====================================
filetype plugin indent on
set nohls
set ttimeoutlen=50
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_next_key='<C-d>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

let g:paredit_mode=0
let g:rainbow_active=1
let rainbow_light =  ['lightblue', 'lightyellow', 'red', 'darkgreen', 'darkyellow', 'lightred', 'yellow', 'cyan', 'magenta', 'white']
let rainbow_dark = ['DarkBlue', 'Magenta', 'Black', 'Red', 'DarkGray', 'DarkGreen', 'DarkYellow']
let g:rainbow_conf = {
\   'ctermfgs': (&background=='light' ? rainbow_dark : rainbow_light)
\}

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

map <C-n> :NERDTreeToggle<CR>
nnoremap <C-T> :FZF<CR>
inoremap <C-T> <ESC>:FZF<CR>i

" =====================================
" Theming
" =====================================
syntax enable
set number
set ruler
set cursorline
set laststatus=2 " https://github.com/vim-airline/vim-airline#configuration

set background=dark
let g:solarized_contrast='high'
" color zenburn
" colorscheme solarized
" let g:airline_theme='solarized'
colorscheme kolor

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

let g:jsx_ext_required=0
let g:flow_path=StrTrim(system('PATH=$(npm bin):$PATH && which flow'))
let g:flow#enable=0
let g:flow#autoclose=1

if has('nvim')
  let g:deoplete#sources#flow#flow_bin = g:flow_path
  let g:neomake_jsx_flow_exe = g:flow_path
  let g:neomake_javascript_flow_exe = g:flow_path
  let g:neomake_javascript_enabled_makers = ['eslint']
  let g:neomake_jsx_enabled_makers = ['eslint']
endif
