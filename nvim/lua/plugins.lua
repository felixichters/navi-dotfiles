return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'tjdevries/express_line.nvim'
    --use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    --use {'nvim-lualine/lualine.nvim',requires = { 'nvim-tree/nvim-web-devicons', opt = true }}
end)
