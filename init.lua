-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true

vim.o.number = true
vim.o.mouse = 'a'
vim.o.showmode = false
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.o.inccommand = 'split'
vim.opt.cursorline = false
vim.o.scrolloff = 10
vim.o.confirm = true

-- Basic keymaps
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Highlight yank
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end
})

-- Install lazy.nvim
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', 'https://github.com/folke/lazy.nvim.git', lazypath }
  if vim.v.shell_error ~= 0 then error('Error cloning lazy.nvim:\n' .. out) end
end
vim.opt.rtp:prepend(lazypath)

-- Plugins
require('lazy').setup({
    'tpope/vim-sleuth',
    'tpope/vim-fugitive',
    'racain/jetbrains-one-dark-theme',
    {
      'lewis6991/gitsigns.nvim',
      opts = {
        signs = {
          add          = { text = '+' },
          change       = { text = '~' },
          delete       = { text = '_' },
          topdelete    = { text = '‾' },
          changedelete = { text = '~' }
        }
      }
    },
    {
      'nvim-neo-tree/neo-tree.nvim',
      branch = 'v3.x',
      dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons',
        'MunifTanjim/nui.nvim'
      },
      keys = {
        { '<leader>e', ':Neotree toggle<CR>', desc = 'Toggle Neo-tree' },
        { '<leader>r', ':Neotree reveal<CR>', desc = 'Reveal current file' }
      },
      config = function()
        require('neo-tree').setup({
          close_if_last_window = true,
          filesystem = {
            follow_current_file = true,
            filtered_items = {
              hide_dotfiles = false,
              hide_gitignored = true
            }
          },
          window = { position = 'left', width = 35, mappings = {} },
          enable_git_status = true
        })
      end
    },
    {
      'kdheepak/lazygit.vim',
      dependencies = { 'nvim-lua/plenary.nvim' },
      keys = { { '<leader>lg', '<cmd>LazyGit<CR>', desc = 'LazyGit' } }
    },
    {
      'folke/which-key.nvim',
      event = 'VimEnter',
      opts = {
        delay = 0,
        icons = {
          mappings = vim.g.have_nerd_font,
          keys = vim.g.have_nerd_font and {} or {
            Up = '<Up>', Down = '<Down>', Left = '<Left>', Right = '<Right>',
            C = '<C-…>', M = '<M-…>', D = '<D-…>', S = '<S-…>',
            CR = '<CR>', Esc = '<Esc>', ScrollWheelDown = '<ScrollWheelDown>',
            ScrollWheelUp = '<ScrollWheelUp>', NL = '<NL>', BS = '<BS>',
            Space = '<Space>', Tab = '<Tab>',
            F1 = '<F1>', F2 = '<F2>', F3 = '<F3>', F4 = '<F4>',
            F5 = '<F5>', F6 = '<F6>', F7 = '<F7>', F8 = '<F8>',
            F9 = '<F9>', F10 = '<F10>', F11 = '<F11>', F12 = '<F12>'
          }
        },
        spec = {
          { '<leader>s', group = '[S]earch' },
          { '<leader>t', group = '[T]oggle' },
          { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } }
        }
      }
    }
  },
  {
    ui = {
      icons = vim.g.have_nerd_font and {} or {
        cmd = '⌘', config = '🛠', event = '📅', ft = '📂', init = '⚙',
        keys = '🗝', plugin = '🔌', runtime = '💻', require = '🌙',
        source = '📄', start = '🚀', task = '📌', lazy = '💤'
      }
    }
  })