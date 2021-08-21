local map = vim.api.nvim_set_keymap

-- space as leader key
map('n', '<Space>', '', {})
vim.g.mapleader = ' '

-- move vertically through visual lines, not logical lines
map('n', 'k', 'gk', {noremap=true})
map('n', 'j', 'gj', {noremap=true})
map('n', 'Up', 'g<Up>', {noremap=true})
map('n', 'Down', 'g<Down>', {noremap=true})
map('n', 'Down', 'g<Down>', {noremap=true})

-- quickly save by double tapping <Esc>
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

-- switch to previous buffer
map('n', '<Leader><Tab>', ':b#<CR>', {noremap=true})

-- quickfix list
map('n', '<Leader>q', '<cmd>Telescope lsp_document_diagnostics<cr>', {noremap=true})

-- open code action list
map('n', '<Leader>ca', '<cmd>Telescope lsp_code_actions<cr>', {noremap=true})
map('v', '<Leader>ca', '<cmd>Telescope lsp_range_code_actions<cr>', {noremap=true})

-- search command history (same keybinding as in shell)
map('n', '<C-R>', '<cmd>lua require("telescope.builtin").command_history()<cr>', {noremap=true})

-- confirm autocomplete with <tab>
local function feedkeys(s)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(s, true, true, true), 'n', true)
end
function expand_tab()
  if vim.fn.pumvisible() == 1 then
    if vim.fn.complete_info({"selected"})["selected"] == -1 then
      vim.api.nvim_input("<C-n><Plug>(completion_confirm_completion)")
    else
      vim.api.nvim_input("<Plug>(completion_confirm_completion)")
    end
  else
    feedkeys("<Tab>")
  end
end
map('i', '<tab>', '<cmd>lua expand_tab()<cr>', {})

-- easily switch between windows with ctrl + direction
map('n', '<C-h>', '<C-W>h', {noremap=true})
map('n', '<C-j>', '<C-W>j', {noremap=true})
map('n', '<C-k>', '<C-W>k', {noremap=true})
map('n', '<C-l>', '<C-W>l', {noremap=true})
map('n', '<C-Left>', '<C-W>h', {noremap=true})
map('n', '<C-Up>', '<C-W>k', {noremap=true})
map('n', '<C-Down>', '<C-W>j', {noremap=true})
map('n', '<C-Right>', '<C-W>l', {noremap=true})

-- [a]le
map('n', '<Leader>af', '<cmd>ALEFix<cr>', {noremap=true})

-- [b]uffer
-- close all but the current buffer
map('n', '<Leader>bo', ':%bd|e#<cr>', {noremap=true})
map('n', '<Leader>bq', '<cmd>Telescope lsp_document_diagnostics<cr>', {noremap=true})
map('n', '<Leader>bs', '<cmd>Telescope lsp_document_symbols<cr>', {noremap=true})

-- [f]ind
map('n', '<Leader>fa', '<cmd>lua require("telescope.builtin").lsp_code_actions()<cr>', {noremap=true})
map('n', '<Leader>fb', '<cmd>lua require("telescope.builtin").buffers()<cr>', {noremap=true})   
map('n', '<Leader>fd', '<cmd>lua require("telescope.builtin").lsp_definitions()<cr>', {noremap=true})
map('n', '<Leader>ff', '<cmd>lua require("telescope.builtin").find_files()<cr>', {noremap=true})
map('n', '<Leader>fg', '<cmd>lua require("telescope.builtin").live_grep()<cr>', {noremap=true})
map('n', '<Leader>fi', '<cmd>lua require("telescope.builtin").lsp_implementations()<cr>', {noremap=true})
map('n', '<Leader>fm', '<cmd>lua require("telescope.builtin").marks()<cr>', {noremap=true})
map('n', '<Leader>fq', '<cmd>lua require("telescope.builtin").lsp_document_diagnostics()<cr>', {noremap=true})
map('n', '<Leader>fr', '<cmd>lua require("telescope.builtin").lsp_references()<cr>', {noremap=true})
map('n', '<Leader>fs', '<cmd>lua require("telescope.builtin").lsp_document_symbols()<cr>', {noremap=true})
map('n', '<Leader>ft', '<cmd>lua require("telescope.builtin").file_browser()<cr>', {noremap=true})
map('n', '<Leader>fv', '<cmd>lua require("telescope.builtin").find_files()<cr>', {noremap=true})

-- [g]it
map('n', '<Leader>gb', '<cmd>lua require("telescope.builtin").git_bcommits()<cr>', {noremap=true})
map('n', '<Leader>gc', '<cmd>lua require("telescope.builtin").git_commits()<cr>', {noremap=true})
map('n', '<Leader>gd', '<cmd>DiffviewOpen<cr>', {noremap=true})
map('n', '<Leader>gs', '<cmd>lua require("telescope.builtin").git_status()<cr>', {noremap=true})

-- [h]op
map('n', '<Leader><Leader>', '<cmd>lua require("hop").hint_words()<cr>', {noremap=true})

-- [r]eplace
map('n', '<Leader>rw', ':%s/<c-r>=expand("<cword>")<cr>/', {noremap=true})

-- [w]indow and [w]orkspace
map('n', '<Leader>w=', '<C-W>=', {noremap=true})
map('n', '<Leader>w<Up>', ':split<CR>', {noremap=true})
map('n', '<Leader>w<Down>', ':split<CR>', {noremap=true})
map('n', '<Leader>w<Left>', ':vsplit<CR>', {noremap=true})
map('n', '<Leader>w<Right>', ':vsplit<CR>', {noremap=true})
map('n', '<Leader>wd', '<cmd>Telescope lsp_workspace_diagnostics<cr>', {noremap=true})
map('n', '<Leader>ws', '<cmd>Telescope lsp_workspace_symbols<cr>', {noremap=true})
