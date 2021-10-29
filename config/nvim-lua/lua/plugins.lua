-- bootstrap https://github.com/wbthomason/packer.nvim
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.api.nvim_command 'packadd packer.nvim'
end

return require('packer').startup(function()
  use {'wbthomason/packer.nvim'}
  use {'nvim-treesitter/nvim-treesitter', run=':TSUpdate'}

  -- ide fundamentals
  use {'editorconfig/editorconfig-vim'}
  use {'neovim/nvim-lspconfig'}
  use {'nvim-lua/completion-nvim'}
  use {'nvim-telescope/telescope.nvim', requires={'nvim-lua/plenary.nvim'}}
  use {'tpope/vim-commentary'}
  use {'kyazdani42/nvim-tree.lua'}

  -- themes
  use {'kyazdani42/nvim-web-devicons'}
  use {'glepnir/galaxyline.nvim', branch='main'}
  use {'EdenEast/nightfox.nvim'}
  use {'maaslalani/nordbuddy'}

  -- version control
  use {'sindrets/diffview.nvim'}
  use {'lewis6991/gitsigns.nvim', requires={'nvim-lua/plenary.nvim'}}

  -- utilities
  use {'tpope/vim-dispatch', opt=true, cmd={'Dispatch', 'Make', 'Focus', 'Start'}}
  use {'phaazon/hop.nvim', as='hop'}

  -- configuration
  require('nvim-tree').setup()
  require('gitsigns').setup()
end)
