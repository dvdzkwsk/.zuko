" vim: foldmethod=marker

" Documentation -------------------------------------------- {{{
" Reference:
" - http://statico.github.io/vim.html
"}}}

" Plugins -------------------------------------------------- {{{
set nocompatible
filetype off
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif
call plug#begin('~/.vim/plugged')

" Core ----------------------------------------------------- {{{
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'airblade/vim-gitgutter'
Plug 'editorconfig/editorconfig-vim'
Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim' " ranger dependency for neovim
"}}}

" Themes --------------------------------------------------- {{{
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'flazz/vim-colorschemes'
Plug 'w0ng/vim-hybrid'
Plug 'lifepillar/vim-solarized8'
"}}}

" JavaScript ----------------------------------------------- {{{
Plug 'pangloss/vim-javascript'
Plug 'othree/es.next.syntax.vim'
"}}}

call plug#end()
filetype plugin indent on
"}}}

" Main Settings -------------------------------------------- {{{
set ttimeoutlen=50
set tabstop=2                      " 2 spaces for tabs
set softtabstop=2                  " ibid
set shiftwidth=2                   " ibid
set expandtab                      " Convert tabs to spaces
set noswapfile                     " Don't create swap files
set number                         " Show line numbers
set cursorline                     " Highlight the currently selected line
set showcmd                        " Show when leader key has been pressed
set wrap                           " Enable visual line wrapping
set textwidth=0
set wrapmargin=0
set ignorecase                     " Ignore case when searching...
set smartcase                      " ...except when search term starts with a capital
set hlsearch                       " highlight active search
set incsearch                      " show search/replace in real time
set modeline
set ruler
set laststatus=2
set wildignore+=.git,*.jpg,*.jpeg,*.png,*.svg

autocmd BufWritePre * %s/\s\+$//e  " Remove trailing whitespace on save

if has('clipboard')
  set clipboard=unnamedplus        " Always copy to system clipboard with yank/delete
endif
if exists('+colorcolumn')
  set colorcolumn=80               " Show line length guide
endif
if exists('&inccommand')
  set inccommand=nosplit
endif
if has('nvim')
  set completeopt-=preview
endif

" Prefer ripgrep over grep
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

" Theming -------------------------------------------------- {{{
if (has("termguicolors"))
  set termguicolors
endif

syntax enable
set background=dark
colorscheme solarized8_dark
let g:airline_theme='solarized'
let g:airline_powerline_fonts=1

fun! Solarized8Contrast(delta)
  let l:schemes = map(["_low", "_flat", "", "_high"], '"solarized8_".(&background).v:val')
  exe "colors" l:schemes[((a:delta+index(l:schemes, g:colors_name)) % 4 + 4) % 4]
endf

call Solarized8Contrast(0)
"}}}

" Custom Keybindings --------------------------------------- {{{
" Space(macs) as my leader. Keep \ as the leader and map space to that key.
" Prefer this method over mapping space directly to the leader, so that there
" is a visual indicator when a command is being entered.
nnoremap <Space> <Nop>
vnoremap <Space> <Nop>
let g:mapleader='\'
nmap <Space> <Leader>
vmap <Space> <Leader>

" Move up/down through visual lines, not logical lines
nnoremap k gk
nnoremap j gj
nnoremap <Up> g<Up>
nnoremap <Down> g<Down>

" Easy movement between panes
noremap <Leader>w<Left> <C-W><C-H>
noremap <Leader>w<Up> <C-W><C-K>
noremap <Leader>w<Down> <C-W><C-J>
noremap <Leader>w<Right> <C-W><C-L>

" Center screen during jump movements
nnoremap n nzz
nnoremap } }zz

" Clear search highlights on ESCAPE
nnoremap <esc> :nohlsearch<return><esc>
nnoremap <esc>^[ <esc>^[

" [B]uffer
nnoremap <Leader>bl :b#<CR>

" [F]ilesystem
nnoremap <Leader>ff :FZF<CR>

" [Q]uickFix List
nnoremap <Leader>ql :copen<CR>

" [W]indow
noremap <Leader>ws :split<CR>
noremap <Leader>wv :vsplit<CR>
"}}}
