local map = vim.api.nvim_set_keymap

-- map the Leader key
map('n', '<Space>', '', {})
vim.g.mapleader = ' '

-- move vertically through visual lines, not logical lines
map('n', 'k', 'gk', {noremap=true})
map('n', 'j', 'gj', {noremap=true})
map('n', 'Up', 'g<Up>', {noremap=true})
map('n', 'Down', 'g<Down>', {noremap=true})
map('n', 'Down', 'g<Down>', {noremap=true})

-- save by double tapping <Esc>
map('', '<Esc><Esc>', ':w<CR>', {noremap=true})

-- clear search highlights with <Esc>
-- https://stackoverflow.com/questions/11940801/mapping-esc-in-vimrc-causes-bizzare-arrow-behaviour
map('n', '<Esc>', ':nohlsearch<return><Esc>', {noremap=true})
map('n', '<Esc>^[', '<Esc>^[', {noremap=true})

-- disable <Shift>-Up/Down in visual mode, which 99% of the time is me
-- accidentally jumping to the top/bottom of the screen. Prefer H and J.
map('v', '<S-Up>', '<NOP>', {noremap=true})
map('v', '<S-Down>', '<NOP>', {noremap=true})

-- center screen when jumping
map('v', 'n', 'nzz', {noremap=true})
map('v', '}', '}zz', {noremap=true})

-- don't yank when deleting a single character in visual mode
map('v', 'x', '_x', {noremap=true})

-- don't automatically jump forward when selecting current word
map('n', '*', '*<c-o>', {noremap=true})

-- persist selection in visual mode after indent
map('v', '>', '>gv', {noremap=true})
map('v', '<', '<gv', {noremap=true})

-- easily switch between windows with ctrl + direction
map('n', '<C-h>', '<C-W>h', {noremap=true})
map('n', '<C-j>', '<C-W>j', {noremap=true})
map('n', '<C-k>', '<C-W>k', {noremap=true})
map('n', '<C-l>', '<C-W>l', {noremap=true})
map('n', '<C-Left>', '<C-W>h', {noremap=true})
map('n', '<C-Up>', '<C-W>k', {noremap=true})
map('n', '<C-Down>', '<C-W>j', {noremap=true})
map('n', '<C-Right>', '<C-W>l', {noremap=true})

-- [b]uffer
map('n', '<Leader><Tab>', ':b#<CR>', {noremap=true})
map('n', '<Leader>bo', ':%bd|e#<CR>', {noremap=true})

-- [f]ind
map('n', '<Leader>ff', '<cmd>Telescope find_files<cr>', {noremap=true})
map('n', '<Leader>fg', '<cmd>Telescope live_grep<cr>', {noremap=true})
map('n', '<Leader>fb', '<cmd>Telescope buffers<cr>', {noremap=true})
map('n', '<Leader>fh', '<cmd>Telescope help_tags<cr>', {noremap=true})

-- [g]if
map('n', '<Leader>gd', '<cmd>DiffviewOpen<cr>', {noremap=true})

-- [r]eplace
map('n', '<Leader>rw', ':%s/<c-r>=expand("<cword>")<cr>/', {noremap=true})

-- [w]indow
map('n', '<Leader>w=', '<C-W>=', {noremap=true})
map('n', '<Leader>w<Up>', ':split<CR>', {noremap=true})
map('n', '<Leader>w<Down>', ':split<CR>', {noremap=true})
map('n', '<Leader>w<Left>', ':vsplit<CR>', {noremap=true})
map('n', '<Leader>w<Right>', ':vsplit<CR>', {noremap=true})
