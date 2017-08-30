" vim: foldmethod=marker

" Documentation -------------------------------------------- {{{
" Reference:
" - http://statico.github.io/vim.html
" - http://www.oliversherouse.com/2017/08/21/vim_zero.html
"}}}

" Plugins -------------------------------------------------- {{{
set nocompatible
filetype off

" Install plugin manager if it does not exist.
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif
call plug#begin('~/.vim/plugged')

" Core ----------------------------------------------------- {{{
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'tpope/vim-commentary'          " Easy commenting
Plug 'tpope/vim-repeat'              " Make `.` work better
Plug 'tpope/vim-surround'            " Easy surround commands
Plug 'tpope/vim-unimpaired'          " More symmetrical mappings
Plug 'tpope/vim-fugitive'            " Sweet Git integration
Plug 'airblade/vim-gitgutter'        " Sidebar Git integration
Plug 'editorconfig/editorconfig-vim' " Use .editorconfig settings when found
Plug 'francoiscabrol/ranger.vim'     " Awesome file navigator
Plug 'rbgrouleff/bclose.vim'         " Ranger dependency for neovim
"}}}

" Themes --------------------------------------------------- {{{
Plug 'chriskempson/base16-vim'
"}}}

" Languages ------------------------------------------------ {{{
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'othree/es.next.syntax.vim'
Plug 'leafgarland/typescript-vim'
Plug 'cakebaker/scss-syntax.vim'
"}}}

call plug#end()
filetype plugin indent on
"}}}

" Main Settings -------------------------------------------- {{{
set ttimeoutlen=50
set noswapfile                     " Don't create swap files
set tabstop=2                      " 2 spaces for tabs
set softtabstop=2                  " ibid
set shiftwidth=2                   " ibid
set expandtab                      " Convert tabs to spaces
set number                         " Show line numbers
set ruler                          " Show current column and line number
set cursorline                     " Highlight the currently selected line
set showcmd                        " Show when leader key has been pressed
set wrap                           " Enable visual line wrapping...
set textwidth=0                    " ...only when text reaches the end of the window
set wrapmargin=0                   " ibid
set ignorecase                     " Ignore case when searching...
set smartcase                      " ...except when search term starts with a capital
set hlsearch                       " Highlight active search
set incsearch                      " Show search/replace in real time
set modeline                       " Enable modeline
set laststatus=2                   " Always show the status line
set wildignore+=.git,*.jpg,*.jpeg,*.png,*.svg

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

" Prevent grep from automatically opening the first matching file.
ca grep grep!

" Prefer ripgrep over grep
if executable('rg')
  set grepprg=rg\ --vimgrep\ --no-heading
  set grepformat=%f:%l:%c:%m
endif

" Remove trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e

" Automatically open the quickfix list when it is populated.
augroup autoOpenQuickFixList
  autocmd!
  autocmd QuickFixCmdPost [^l]* cwindow
  autocmd QuickFixCmdPost l*    lwindow
augroup END
"}}}

" Theming -------------------------------------------------- {{{
syntax enable
set background=dark
colorscheme base16-spacemacs
let g:airline_powerline_fonts=1

if (has("termguicolors"))
  set termguicolors
endif
"}}}

" Keybindings --------------------------------------- {{{
" Space(macs) as my leader. Keep \ as the leader and map space to that key.
" Prefer this method over mapping space directly to the leader, so that there
" is a visual indicator when a command is being entered.
nnoremap <Space> <Nop>
vnoremap <Space> <Nop>
let g:mapleader='\'
nmap <Space> <Leader>
vmap <Space> <Leader>

" Move vertically through visual lines, not logical lines
nnoremap k gk
nnoremap j gj
nnoremap <Up> g<Up>
nnoremap <Down> g<Down>

" Easy line movement
nnoremap <C-Up> :m .-2<CR>==
nnoremap <C-Down> :m .+1<CR>==

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
nnoremap <Leader>bl :ls<CR>
nnoremap <Leader>bn :bn<CR>
nnoremap <Leader>bp :bp<CR>

" [F]ilesystem
nnoremap <Leader>ff :FZF<CR>
nnoremap <Leader>fr :Ranger<CR>

" [Q]uickFix List
nnoremap <Leader>ql :copen<CR>

" [W]indow
noremap <Leader>ws :split<CR>
noremap <Leader>wv :vsplit<CR>
"}}}
