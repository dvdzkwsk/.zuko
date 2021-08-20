-- bootstrap https://github.com/wbthomason/packer.nvim
local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

return require('packer').startup(function()
  use {'wbthomason/packer.nvim'}
  use {'nvim-treesitter/nvim-treesitter', run=':TSUpdate'}

  -- developer experience
  -- use {'glepnir/dashboard-nvim'}
  use {'tpope/vim-dispatch', opt=true, cmd={'Dispatch', 'Make', 'Focus', 'Start'}}
  use {'nvim-telescope/telescope.nvim', requires={'nvim-lua/plenary.nvim'}}
  use {'neovim/nvim-lspconfig'}

  -- version control
  use {'sindrets/diffview.nvim'}
  use {'lewis6991/gitsigns.nvim', requires={'nvim-lua/plenary.nvim'}}

  -- themes
  use {'glepnir/galaxyline.nvim', branch='main'}
  use {'kyazdani42/nvim-web-devicons', opt=true}
  use {'EdenEast/nightfox.nvim'}
  use {'maaslalani/nordbuddy'}
  require('statusline')

  -- configuration
  require('gitsigns').setup()
  require('nordbuddy').colorscheme({
    underline_option = 'none',
    italic = false,
    italic_comments = false,
    minimal_mode = false
  })
end)
