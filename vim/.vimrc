" ==============================
" Vundle (Package Manager)
" ==============================
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" =============================
" Vundle Plugins
" =============================
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'pangloss/vim-javascript'
Plugin 'flazz/vim-colorschemes'

" ==============================
" General
" ==============================
" Automatically open NERDTree on start
" autocmd VimEnter * NERDTree
set ttimeoutlen=50

" ==============================
" Spacing
" ==============================
set tabstop=2
set shiftwidth=2
set expandtab

" ==============================
" Custom Hotkeys
" ==============================
" Toggle Nerdtree Open/Close
map <C-n> :NERDTreeToggle<CR>

" ==============================
" End Vundle
" ==============================
call vundle#end()
filetype plugin indent on

" ==============================
" Theming
" ==============================
set t_Co=256
set number
set ruler
set cursorline
syntax enable
set laststatus=2 " https://github.com/vim-airline/vim-airline#configuration

" This is needed as a fallback when the terminal is not using
" the solarized color scheme itself.
" let g:solarized_termcolors=256
set background=light
colorscheme solarized

" Color scheme override when I don't feel like using solarized
" as my default terminal theme.
colorscheme molokai

" Fix arrows in airline status bar. If they are not working, make sure this
" is enabled and that your terminal is configured to use a patched powerline
" font for non-ascii characters. See: https://github.com/powerline/fonts
let g:airline_powerline_fonts=1
