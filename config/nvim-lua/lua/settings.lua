-- theme
-- https://github.com/edeneast/nightfox.nvim#lua
require('nightfox').load("duskfox")

-- global settings
vim.opt.ttimeoutlen=50                             -- reduce input delay when entering normal mode
vim.opt.swapfile=false                             -- don't create swap files
vim.opt.undofile=true                              -- remember undo history between sessions...
vim.opt.undodir='/tmp/.vim/undo'                   -- ...and store it here
vim.opt.hidden=true                                -- allow unsaved buffers (i.e. switch buffers w/o saving current)
vim.opt.autoread=true                              -- automatically reload file changes outside of vim
vim.opt.expandtab=true                             -- convert tabs to spaces
vim.opt.tabstop=4                                  -- number of spaces for a tab
vim.opt.softtabstop=4                              -- ^^
vim.opt.shiftwidth=4                               -- number of spaces for a shift motion (e.g. indent)
vim.opt.shiftround=true                            -- constraint shifts to multiples of shiftwidth
vim.opt.number=true                                -- show line numbers
vim.opt.ruler=true                                 -- show current column and line number
vim.opt.cursorline=true                            -- highlight the current line
vim.opt.showmode=false                             -- do not show -- MODE -- indicator below statusline
vim.opt.showcmd=true                               -- show when leader key has been pressed
vim.opt.wrap=true                                  -- enable visual line wrapping
vim.opt.wrapmargin=0                               -- number of characters from the window edge to start wrapping
vim.opt.foldmethod='syntax'                        -- fold based on language syntax
vim.opt.foldlevelstart=20                          -- automatically expand all folds (up to 20 levels)
vim.opt.ignorecase=true                            -- ignore case when searching...
vim.opt.smartcase=true                             -- ...except when search term starts with a capital
vim.opt.hlsearch=true                              -- highlight active search matches
vim.opt.incsearch=true                             -- show search/replace in real time
vim.opt.modeline=true                              -- allow files to configure vim (see top of this file)
vim.opt.laststatus=2                               -- always show the status line
vim.opt.scrolloff=3                                -- number of rows to keep visible above/below scroll threshold
vim.opt.sidescrolloff=3                            -- number of columns to keep visible past the cursor
vim.opt.sidescroll=1                               -- scroll columns incrementally at max width (don't jump)
vim.opt.splitright=true                            -- open new vertical splits to the right
vim.opt.splitbelow=true                            -- open new horizontal splits below
vim.opt.mouse='a'                                  -- enable mouse interaction, for when all else fails
vim.opt.lazyredraw=true                            -- better rendering performance
vim.opt.ttyfast=true                               -- improve redraw speed (enabled by default in neovim)
vim.opt.backspace={"indent", "eol", "start"}       -- allow backspacing over these regions (nvim -> vim compat)
vim.opt.diffopt:append({"vertical"})
vim.opt.wildignore:append({"*.jpg", "*.jpeg", "*.png", "*.svg"})

-- better completion experience
vim.opt.completeopt={"menuone","noinsert","noselect"}

-- avoid showing message extra message when using completion
vim.cmd 'set shortmess+=c'

-- fixes crontab (reference?)
vim.opt.backupcopy='yes'

-- only show cursor line in active window
vim.api.nvim_exec([[ autocmd BufEnter * setlocal cursorline ]], false)
vim.api.nvim_exec([[ autocmd BufLeave * setlocal nocursorline ]], false)

-- plugin configuration
vim.cmd "let g:ale_lint_on_enter=0"
vim.cmd "let g:ale_lint_on_save=0"
vim.cmd "let g:ale_lint_on_insert_leave=0"
vim.cmd "let g:ale_fix_on_save=0"
vim.cmd "let g:ale_linters_explicit=1"
vim.cmd "let g:ale_fixers={'javascript':['eslint'],'typescript':['eslint'],'typescriptreact':['eslint'],'css':['prettier']}"
