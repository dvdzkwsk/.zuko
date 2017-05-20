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
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'airblade/vim-gitgutter'
Plug 'editorconfig/editorconfig-vim'
Plug 'luochen1990/rainbow'
"}}}
" Themes {{{
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'flazz/vim-colorschemes'
Plug 'w0ng/vim-hybrid'
"}}}
" JavaScript {{{
Plug 'pangloss/vim-javascript'
Plug 'othree/es.next.syntax.vim'
Plug 'mxw/vim-jsx'
"}}}
call plug#end()
"}}}
" Core Settings {{{
filetype plugin indent on
set ttimeoutlen=50

" Don't create swap files. I'm not hardcore enough, yet, apparently.
set noswapfile

" Use both `number` and `relativenumber` for hybrid mode, where
" the current line shows the actual line number, and all others
" are relative to the current line.
set number
set relativenumber

" Show that the leader key has been pressed when we are entering a command
set showcmd

" Convert tabs to spaces, and set global tab width to 2
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

" Enable visual line wrapping, but disable physical wrapping (where actual
" line breaks are automatically inserted)
set wrap
set textwidth=0
set wrapmargin=0

" Highlight the currently selected line
set cursorline

" Display line length guide
if exists('+colorcolumn')
  set colorcolumn=80
endif

" Ignore case when searching, except when search starts with a capital letter
set ignorecase
set smartcase

" Incrementally highlight text matching search in realtime
set hlsearch
set incsearch
if exists('&inccommand')
  set inccommand=nosplit
endif

" Airline Configuration
set modeline
set ruler
set laststatus=2

" Always copy to system clipboard with yank/delete
if has('clipboard')
  set clipboard=unnamedplus
endif

" Autocompletion / search
set wildignore+=.git
set wildignore+=*.jpg,*.jpeg,*.png,*.svg

if has('nvim')
  set completeopt-=preview
endif

" Remove trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e

" Prefer ripgrep over grep when it is available
if executable('rg')
  set grepprg=rg\ --vimgrep\ --no-heading
  set grepformat=%f:%l:%c:%m

  " prevent grep from automatically opening the first matching file.
  ca grep grep!
endif

" Automatically open the quickfix list when it is populated.
augroup autoOpenQuickFixList
  autocmd!
  autocmd QuickFixCmdPost [^l]* cwindow
  autocmd QuickFixCmdPost l*    lwindow
augroup END
"}}}
" Language Support {{{
let g:jsx_ext_required=0
"}}}
" Mappings {{{
" Space(macs) as my leader. Keep \ as the leader and map space to that key.
" Prefer this method over mapping space directly to the leader, so that there
" is a visual indicator when a command is being entered.
nnoremap <Space> <Nop>
vnoremap <Space> <Nop>
let g:mapleader='\'
nmap <Space> <Leader>
vmap <Space> <Leader>

" http://statico.github.io/vim.html
" Move up/down through visual lines, not logical lines
nnoremap k gk
nnoremap j gj
nnoremap <Up> g<Up>
nnoremap <Down> g<Down>

" Center screen during jump movements
nnoremap n nzz
nnoremap } }zz

" Clear search highlights on ESC
nnoremap <esc> :nohlsearch<return><esc>
nnoremap <esc>^[ <esc>^[

" Buffer
nnoremap <Leader>bl :b#<CR>

" Filesystem
nnoremap <Leader>ff :FZF<CR>

" Project
" nnoremap <Leader>pt :NERDTreeToggle<CR>

" Git
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gc :Gcommit<CR>
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gl :Glog<CR>

" QuickFix List
nnoremap <Leader>ql :copen<CR>

" Window
noremap <Leader>ws :split<CR>
noremap <Leader>wv :vsplit<CR>

" Move between panes
noremap <Leader>wh <C-W><C-H>
noremap <Leader>wk <C-W><C-K>
noremap <Leader>wj <C-W><C-J>
noremap <Leader>wl <C-W><C-L>
noremap <Leader>w<Left> <C-W><C-H>
noremap <Leader>w<Up> <C-W><C-K>
noremap <Leader>w<Down> <C-W><C-J>
noremap <Leader>w<Right> <C-W><C-L>
"}}}
" Theming {{{
syntax enable
colorscheme hybrid
set background=dark
let g:airline_theme='bubblegum'
let g:airline_powerline_fonts=1
let g:rainbow_active=1
let rainbow_light = ['lightblue', 'lightyellow', 'red', 'darkgreen', 'darkyellow', 'lightred', 'yellow', 'cyan', 'magenta', 'white']
let rainbow_dark = ['DarkBlue', 'Magenta', 'Black', 'Red', 'DarkGray', 'DarkGreen', 'DarkYellow']
let g:rainbow_conf = {
\   'ctermfgs': (&background=='light' ? rainbow_dark : rainbow_light)
\}
"}}}
