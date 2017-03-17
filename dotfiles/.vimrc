" vim: foldmethod=marker

" Plugins {{{
set nocompatible
filetype off

" Plugin Manager {{{
" Automatically install vim-plug if it does not exist
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif
call plug#begin('~/.vim/plugged')
"}}}

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
Plug 'editorconfig/editorconfig-vim'
Plug 'ervandew/supertab'
Plug 'luochen1990/rainbow'
Plug 'benmills/vimux'
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

call plug#end()
"}}}

" Core Settings {{{
filetype plugin indent on
set ttimeoutlen=50

" Don't create swap files
set noswapfile

" Use both `number` and `relativenumber` for hybrid mode, where
" the current line shows the actual line number, and all others
" are relative to the current line.
set number
set relativenumber

" Show that leader has been pressed and we are typing a command
set showcmd

" Convert tabs to spaces
set expandtab

" Set global tab width to 2
set tabstop=2
set softtabstop=2
set shiftwidth=2

" Enable visual wrapping, but disable physical wrapping (where line breaks
" are automatically inserted)
set wrap
set textwidth=0
set wrapmargin=0

" Display line length guide
if exists('+colorcolumn')
  set colorcolumn=80
endif

" Ignore case when searching, except when search starts with a capital letter
set ignorecase
set smartcase
set hlsearch

" Airline
set modeline
set ruler
set cursorline
set laststatus=2 " https://github.com/vim-airline/vim-airline#configuration
set incsearch

" Always copy to system clipboard with yank/delete
if has('clipboard')
  set clipboard=unnamedplus
endif

if has('nvim')
  let g:deoplete#enable_at_startup=1
  let g:deoplete#enable_refresh_always=1
  let g:SuperTabDefaultCompletionType="<c-n>"
  let g:tern_request_timeout=1
  let g:tern_show_signature_in_pum=0
  set completeopt-=preview
endif

" Remove trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e
"}}}

" Mappings {{{
" Space(macs) as my leader. Keep \ as the leader and map space to that key.
" Prefer this method over mapping space directly to the leader, so that there
" is a visual indicator when a command is being entered.
nnoremap <Space> <Nop>
let mapleader='\'
nmap <Space> <Leader>

" http://statico.github.io/vim.html
" Move up/down through visual lines, not logical lines
nnoremap k gk
nnoremap j gj
nnoremap <Up> g<Up>
nnoremap <Down> g<Down>

" Clear higlights on escape
nnoremap <esc> :noh<return><esc>

" Mnemonic Commands {{{
" Filesystem
nnoremap <Leader>ff :FZF<CR>

" Project
nnoremap <Leader>pt :NERDTreeToggle<CR>

" Git
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gc :Gcommit<CR>
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gl :Glog<CR>

" Vimux
function! VimuxOpenREPL()
  call VimuxOpenRunner()
  call VimuxSendText("node")
  call VimuxSendKeys("Enter")
endfunction

function! VimuxSlime()
  call VimuxSendText(@v)
  call VimuxSendKeys("Enter")
endfunction

vnoremap <Space> <NOP>
nnoremap <Leader>vo :call VimuxOpenREPL()<CR>
vnoremap <Space>vr "vy:call VimuxSlime()<CR>
nnoremap <Leader>vr vip"vy:call VimuxSlime()<CR>

" Window
map <Leader>ws :split<CR>
map <Leader>wv :vsplit<CR>
map <Leader>w<Left> <C-W><C-H>
map <Leader>w<Up> <C-W><C-J>
map <Leader>w<Down> <C-W><C-K>
map <Leader>w<Right> <C-W><C-L>
"}}}
"}}}

" Theming {{{
syntax enable
let g:airline_powerline_fonts=1
let g:rainbow_active=1

" Somebody teach me vimscript...
function! SetTheme(theme)
  set background=dark
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

:call SetTheme('hybrid')
"}}}
