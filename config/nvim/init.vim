" vim: foldmethod=marker
" Plugins -------------------------------------------------- {{{
" Install plugin manager if it does not exist
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.local/share/nvim/plugged')

" Basics
Plug 'editorconfig/editorconfig-vim'  " Use .editorconfig settings when found
Plug '/usr/local/opt/fzf'             " Import native FZF binary (brew install fzf)
Plug 'junegunn/fzf.vim'               " FZF integration
Plug 'jesseleite/vim-agriculture'     " Better :Rg and :Ag for fzf.vim
Plug 'dense-analysis/ale'             " Asynchronous Lint Engine
Plug 'scrooloose/nerdtree'            " File explorer
Plug 'christoomey/vim-tmux-navigator' " Seamlessly navigate between tmux and vim
Plug 'neoclide/coc.nvim', {'tag': '*'}

" Editing iMproved
Plug 'tpope/vim-commentary'           " Easier commenting
Plug 'tpope/vim-repeat'               " Make '.' smarter
Plug 'tpope/vim-unimpaired'           " More symmetrical mappings
Plug 'tpope/vim-abolish'              " Smarter text manipulation and replacement
Plug 'machakann/vim-sandwich'         " Intuitive surround commands
Plug 'wellle/targets.vim'             " More, smarter text objects

" Version Control
Plug 'tpope/vim-fugitive'             " Git integration
Plug 'mhinz/vim-signify'              " VCS (e.g. git) indicators in sidebar

" Language Support
Plug 'sheerun/vim-polyglot'           " Suite of language packages
Plug 'tpope/vim-fireplace'            " Clojure integration
Plug 'tpope/vim-classpath'            " ^^
Plug 'bhurlow/vim-parinfer'           " Inferred parentheses for lisps
Plug 'fatih/vim-go'                   " Advanced Go support (improves upon vim-polygot)

" Theming
Plug 'itchyny/lightline.vim'          " Customizable status line
Plug 'liuchengxu/space-vim-dark'
Plug 'arcticicestudio/nord-vim'
Plug 'davezuko/vim-monochrome'
Plug 'ayu-theme/ayu-vim'

call plug#end()
filetype plugin indent on
"}}}

" Main Settings -------------------------------------------- {{{
set ttimeoutlen=50                    " Reduce input delay when entering normal mode
set undofile                          " Remember undo history between sessions...
set undodir=/tmp/.vim/undo            " ...and store it here
set noswapfile                        " Don't create swap files
set hidden                            " Allow unsaved buffers (i.e. switch buffers w/o saving current)
set autoread                          " Automatically reload file changes outside of vim
set expandtab                         " Convert tabs to spaces
set tabstop=2                         " Number of spaces for a tab
set softtabstop=2                     " ibid
set shiftwidth=2                      " Number of spaces for a shift motion (e.g. indent)
set shiftround                        " Round indents to multiples of shiftwidth
set backspace=indent,eol,start        " Allow backspacing over these regions (nvim -> vim compat)
set number                            " Show line numbers
set ruler                             " Show current column and line number
set cursorline                        " Highlight the current line
set noshowmode                        " Do not show -- MODE -- indicator below statusline
set showcmd                           " Show when leader key has been pressed
set wrap                              " Enable visual line wrapping
set wrapmargin=0                      " Number of characters from the window edge to start wrapping
set foldmethod=syntax                 " Fold based on language syntax
set foldlevelstart=20                 " Automatically expand all folds (well, up to 20 levels)
set ignorecase                        " Ignore case when searching...
set smartcase                         " ...except when search term starts with a capital
set hlsearch                          " Highlight active search matches
set incsearch                         " Show search/replace in real time
set modeline                          " Enable modeline
set laststatus=2                      " Always show the status line
set diffopt+=vertical                 " Split diffs vertically (left/right pane)
set scrolloff=3                       " Number of rows to keep visible above/below scroll threshold
set sidescrolloff=3                   " Number of columns to keep visible past the cursor
set sidescroll=1                      " Scroll columns incrementally at max width (don't jump)
set splitright                        " Open new vertical splits to the right
set splitbelow                        " Open new horizontal splits below
set mouse=a                           " Enable mouse interaction, for when all else fails
set lazyredraw                        " Better rendering performance
set ttyfast                           " Improve redraw speed (enabled by default in neovim)
set wildignore+=*.jpg,*.jpeg,*.png,*.svg

if has('clipboard')
  set clipboard=unnamedplus           " Use system clipboard with yank/delete
endif
if exists('&inccommand')
  set inccommand=nosplit              " Preview regex substitutions in place
endif

" Replace grep with ripgrep
if executable('rg')
  set grepprg=rg\ --vimgrep\ --no-heading
  set grepformat=%f:%l:%c:%m
endif

" Prevent grep from automatically opening the first matching file
ca grep grep!
"}}}

" Plugin Configurations ------------------------------------ {{{
let $FZF_DEFAULT_COMMAND='rg --files'

" Enable tab completion with coc.vim

" Implementation #1: <Tab> cycles through completion list. <Enter> confirms.
" inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
" autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" Implementation #1: <Tab> confirms completion. Use <Arrow>s to cycle.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
let g:coc_snippet_next = '<tab>'

let g:ale_fix_on_save=1
let g:ale_linters = {
\  'typescript': [],
\  'typescript.jsx': [],
\}
let g:ale_fixers={
\  'go': ['goimports'],
\  'css': ['prettier'],
\  'markdown': ['prettier'],
\  'javascript': ['prettier'],
\  'javascript.jsx': ['prettier'],
\  'typescript': ['tslint', 'prettier'],
\  'typescript.jsx': ['tslint', 'prettier'],
\}

let g:vimwiki_table_mappings=0
let g:vimwiki_list=[
\  {'path': '~/wiki/', 'syntax': 'markdown', 'ext': '.md'}
\]
"}}}

" Auto Commands -------------------------------------------- {{{
" Filetype configuration
autocmd FileType vimwiki setlocal syntax=markdown
autocmd BufNewFile,BufRead *.tsx set filetype=typescript.jsx
autocmd BufNewFile,BufRead crontab.* set nobackup | set nowritebackup

" Only show cursor line in active window
autocmd BufEnter * setlocal cursorline
autocmd BufLeave * setlocal nocursorline

" Remove trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e

" Automatically open the quickfix list when it gets populated
autocmd QuickFixCmdPost [^l]* cwindow
autocmd QuickFixCmdPost l*    lwindow
"}}}

" Theming -------------------------------------------------- {{{
" Don't clobber existing syntax highlighting if config is re-sourced.
if !exists('g:syntax_on')
  syntax enable
endif
if has("termguicolors")
  set termguicolors
endif

set background=dark
let ayucolor="mirage"
colorscheme nord

" Lightline (favorites themes: deus, solarized, palenight)
let g:lightline = {
\   'colorscheme': 'nord',
\   'component': {
\     'readonly': '%{&readonly?"\ue0a2":""}',
\   },
\   'active': {
\     'left': [
\       ['mode', 'paste'],
\       ['readonly', 'relativepath', 'modified']
\     ],
\     'right': [
\        ['lineinfo'],
\        ['filetype'],
\     ]
\   },
\   'inactive': {
\     'right': [
\        ['lineinfo'],
\        ['gitversion', 'percent'],
\     ]
\   },
\ }

" Signify (VCS Gutter)
let g:signify_show_count=1
let g:signify_sign_add='●'
let g:signify_sign_change='●'
let g:signify_sign_delete='-'

" Fix vim-jsx not coloring closing tags properly. Seriously?
" https://github.com/mxw/vim-jsx/issues/124
hi link xmlEndTag xmlTag
hi Tag        ctermfg=04
hi xmlTag     ctermfg=04
hi xmlTagName ctermfg=04
hi xmlEndTag  ctermfg=04
hi xmlTagName guifg=#59ACE5
hi xmlTag     guifg=#59ACE5
hi xmlEndTag  guifg=#2974a1
"}}}

" Keybindings ---------------------------------------------- {{{
let g:mapleader=' '

" Enter command mode without <shift>
nnoremap ; :

" More efficient file saving by double tapping <Esc>
noremap <Esc><Esc> :w<CR>

" Move vertically through visual lines, not logical lines
nnoremap k gk
nnoremap j gj
nnoremap <Up> g<Up>
nnoremap <Down> g<Down>

" Custom unimpaired bindings
nmap <silent> [w <Plug>(coc-diagnostic-prev)
nmap <silent> ]w <Plug>(coc-diagnostic-next)

" Show documentation
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Disable Shift-Up/Down in visual mode, which 99% of the time is me
" accidentally jumping to the top/bottom of the screen. Prefer H and J.
vnoremap <S-Up> <NOP>
vnoremap <S-Down> <NOP>

" Center screen when jumping
nnoremap n nzz
nnoremap } }zz

" Don't yank when deleting a single character
nnoremap x "_x

" Clear search highlights on Escape...
nnoremap <Esc> :nohlsearch<return><Esc>
" ...but mapping Escape causes weird arrow key behavior, so fix that
" https://stackoverflow.com/questions/11940801/mapping-esc-in-vimrc-causes-bizzare-arrow-behaviour
nnoremap <Esc>^[ <Esc>^[

" Don't automatically jump forward when selecting current word
nnoremap * *<c-o>

" Persist selection in visual mode after indent
vnoremap > >gv
vnoremap < <gv

" Make `gs` useful: search/replace in current buffer (default: sleep)
nnoremap gs :%Subvert/

" Quick access to the macro in the `q` register; I don't care about Ex mode
nnoremap Q @q
xnoremap Q :normal @q<CR>

" Don't show filenames when executing :Ag (aliased to `<leader>fa`)
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)

" Helpful mappings for coc.vim
nmap <silent> <leader>dd <Plug>(coc-definition)
nmap <silent> <leader>dr <Plug>(coc-references)
nmap <silent> <leader>dj <Plug>(coc-implementation)

" Quickly fuzzy search current directory
nmap <Leader>/ <Plug>RgRawSearch
vmap <Leader>/ <Plug>RgRawVisualSelection
nmap <Leader>* <Plug>RgRawWordUnderCursor

" Go to code
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
"}}}
"
" Language Configuration ----------------------------------- {{{
" Go
let g:go_auto_type_info=1  " show type info of variable under cursor

" Clojure
autocmd FileType clojure nnoremap <buffer> <leader>e <Plug>FireplaceCountPrint
"}}}

" Mnemonics ------------------------------------------------ {{{
" [B]uffer
nnoremap <Leader><Tab> :b#<CR>
nnoremap <Leader>bb :Buffers<CR>
nnoremap <Leader>bo :%bd\|e#<CR>
nnoremap <Leader>bf :ALEFix<CR>

" [C]oc
nnoremap <Leader>cc :CocConfig<CR>
nnoremap <Leader>cs :CocCommand snippets.editSnippets<CR>
nmap <leader>cr <Plug>(coc-rename)
xmap <leader>ca <Plug>(coc-codeaction-selected)
nmap <leader>ca <Plug>(coc-codeaction-selected)
nmap <leader>ca <Plug>(coc-codeaction)
nmap <leader>cf <Plug>(coc-fix-current)

" [F]ind
nnoremap <Leader>fa :Ag<CR>
nnoremap <Leader>ff :FZF<CR>
nnoremap <Leader>fw :grep! "<cword>"<CR>

" [G]it
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gb :Gbrowse<CR>
nnoremap <Leader>gc :Gcommit<CR>
nnoremap <Leader>gd :Gdiff<CR>

" [P]roject
nnoremap <Leader>pt :NERDTreeToggle<CR>
nnoremap <Leader>pf :GFiles<CR>

" [V]im
nnoremap <Leader>vc :e $MYVIMRC<CR>
nnoremap <leader>vs :source $MYVIMRC<CR>
nnoremap <leader>vi :PlugInstall<CR>

" [W]indow
nnoremap <Leader>w= <C-W>=
nnoremap <Leader>w<Down> :split<CR>
nnoremap <Leader>w<Right> :vsplit<CR>
"}}}
