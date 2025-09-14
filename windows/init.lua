-- <leader> key
vim.g.mapleader = ' '

-- open config
vim.cmd('nmap <leader>co :e C:\\Users\\kanil\\AppData\\Local\\nvim\\init.lua<cr>')
vim.cmd('nmap <leader>ko :e C:/Users/kanil/AppData/Roaming/Cursor/User/keybindings.json<cr>')

-- save
vim.cmd('nmap <leader>s :w<cr>')

vim.keymap.set("i", "jf", "<Esc>", { noremap = true, silent = true })

-- paste without overwriting
vim.keymap.set('v', 'p', 'P')

-- fast move
vim.keymap.set('v', 'J', '5j')
vim.keymap.set('v', 'K', '5k')
vim.keymap.set('n', 'J', '5j')
vim.keymap.set('n', 'K', '5k')

-- redo
vim.keymap.set('n', 'U', '<C-r>')

-- clear search highlighting
vim.keymap.set('n', '<esc>', '<cmd>nohlsearch<cr>')

-- sync system clipboard
vim.opt.clipboard = 'unnamedplus'

-- search ignoring case
vim.opt.ignorecase = true

-- disable "ignorecase" option if the search pattern contains upper case characters
vim.opt.smartcase = true

if vim.g.vscode then
  local opts = { noremap = true, silent = true }

  local mappings = {
    { 'n', 'q',          'workbench.action.closeActiveEditor' },

    { 'n', 'w',          'cursorWordPartRight' },
    { 'v', 'w',          'cursorWordPartRightSelect' },

    { 'n', '<leader>gd', 'editor.action.revealDefinition' },
    { 'n', '<leader>gy', 'editor.action.goToTypeDefinition' },
    { 'n', '<leader>gi', 'editor.action.goToImplementation' },
    { 'n', '<leader>gr', 'editor.action.goToReferences' },
    { 'n', '<leader>gs', 'workbench.action.gotoSymbol' },
    { 'n', '<leader>nb', 'workbench.action.navigateBack' },
    { 'n', '<leader>je', 'workbench.action.navigateToLastEditLocation' },

    { 'n', '<leader>sa', 'workbench.action.showCommands' },
    { 'n', '<leader>sf', 'workbench.action.quickOpen' },
    { 'n', '<leader>vd', 'editor.action.peekDefinition' },
    { 'n', '<leader>vi', 'editor.action.peekImplementation' },
    { 'n', '<leader>vt', 'editor.action.peekTypeDefinition' },
    { 'n', '<leader>vh', 'editor.action.showHover' },
    { 'n', '<leader>fr', 'references-view.findReferences' },
    { 'n', '<leader>sr', 'editor.action.referenceSearch.trigger' },

    { 'n', '<leader>ff', 'actions.find' },
    { 'n', '<leader>fr', 'editor.action.startFindReplaceAction' },
    { 'n', '<leader>fg', 'workbench.action.findInFiles' },
    { 'n', '<leader>rg', 'workbench.action.replaceInFiles' },
    { 'n', '<leader>re', 'editor.action.rename' },
    { 'n', '<leader>rf', 'editor.action.refactor' },
    { 'n', '<leader>qf', 'editor.action.quickFix' },
    { 'n', '<leader>sg', 'editor.action.triggerSuggest' },

    { 'n', '<leader>lu', 'editor.action.copyLinesUpAction' },
    { 'n', '<leader>ld', 'editor.action.copyLinesDownAction' },
    { 'n', '<leader>mu', 'editor.action.moveLinesUpAction' },
    { 'n', '<leader>md', 'editor.action.moveLinesDownAction' },
    { 'n', '<leader>fm', 'editor.action.formatDocument' },
    { 'n', '<leader>oi', 'editor.action.organizeImports' },

    { 'n', '<leader>cp', 'copyFilePath' },
    { 'n', '<leader>cr', 'copyRelativeFilePath' },
    { 'n', '<leader>rl', 'workbench.action.openRecent' },
    { 'n', '<leader>nf', 'workbench.action.files.newUntitledFile' },
    { 'n', '<leader>fa', 'workbench.action.closeAllEditors' },
    { 'n', '<leader>of', 'workbench.action.files.openFile' },
    { 'n', '<leader>rw', 'workbench.action.reloadWindow' },
    { 'n', '<leader>os', 'workbench.action.openSettingsJson' },

    { 'n', '<leader>e',  'workbench.action.toggleSidebarVisibility' },
  }

  for _, mapping in ipairs(mappings) do
    local mode, key, command = mapping[1], mapping[2], mapping[3]

    vim.keymap.set(mode, key, function() vim.fn.VSCodeNotify(command) end, opts)
  end
end

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({ 'git', 'clone', '--filter=blob:none', 'https://github.com/folke/lazy.nvim.git', '--branch=stable',
    lazypath })
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  {
    'vscode-neovim/vscode-multi-cursor.nvim',
    event = 'VeryLazy',
    cond = not not vim.g.vscode,
    opts = {}
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
  }
})

-- vscode-multi-cursor
vim.api.nvim_set_hl(0, 'VSCodeCursor', {
  bg = '#542fa4',
  fg = 'white',
  default = true
})

vim.api.nvim_set_hl(0, 'VSCodeCursorRange', {
  bg = '#542fa4',
  fg = 'white',
  default = true
})

local cursors = require('vscode-multi-cursor')

vim.keymap.set({'n', 'x', 'i'}, '<c-d>', function()
  cursors.addSelectionToNextFindMatch()
end)

vim.keymap.set({'n', 'x', 'i'}, '<cs-d>', function()
  cursors.addSelectionToPreviousFindMatch()
end)

vim.keymap.set({'n', 'x', 'i'}, '<cs-l>', function()
  cursors.selectHighlights()
end)

vim.keymap.set('n', '<c-d>', 'mciw*:nohl<cr>', {
  remap = true
})

-- flash
vim.api.nvim_set_hl(0, 'FlashLabel', {
  bg = '#e11684',
  fg = 'white'
})

vim.api.nvim_set_hl(0, 'FlashMatch', {
  bg = '#7c634c',
  fg = 'white'
})

vim.api.nvim_set_hl(0, 'FlashCurrent', {
  bg = '#7c634c',
  fg = 'white'
})