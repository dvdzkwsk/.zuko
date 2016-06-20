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
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'pangloss/vim-javascript'

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
" Theming
" ==============================
set number
set ruler
set cursorline
syntax enable
set background=dark
colorscheme solarized

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
