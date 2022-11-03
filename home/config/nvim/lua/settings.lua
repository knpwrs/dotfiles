--
-- General Settings
-- :h defaults
--

local cmd = vim.cmd
local env = vim.env
local g = vim.g
local o = vim.o
local opt = vim.opt

-- File encoding
if vim.fn.has('vim_starting') then
  o.encoding = 'utf-8'
  o.fileencoding = 'utf-8'
  o.fileencodings = 'utf-8'
end

-- Load plugins according to detected filetype
cmd('filetype plugin indent on', false)

-- Enable syntax highlighting
cmd('syntax on', false)

-- Highlight coloring
cmd('hi Visual cterm=NONE ctermbg=0 ctermfg=NONE')
cmd('hi Search cterm=NONE ctermbg=0 ctermfg=white')
cmd('hi Pmenu cterm=NONE ctermbg=white ctermfg=0')
cmd('hi MatchParen cterm=NONE ctermbg=NONE ctermfg=red')

-- Set <Leader> to <Space>
g.mapleader = ' '
-- Use spaces instead of tabs.
o.expandtab = true
-- Tab key indents by 2 spaces.
o.softtabstop = 2
-- >> indents by 2 spaces.
o.shiftwidth = 2
-- Switch between buffers without having to save first.
o.hidden = true
-- Show current mode in command-line.
o.showmode = true
-- Ignore case when searching.
o.ignorecase = true
-- If a search contains an uppercase letter, it is case-sensitive.
o.smartcase = true
-- Only redraw when necessary.
o.lazyredraw = true
-- Open new windows below the current window.
o.splitbelow = true
-- Open new windows right of the current window.
o.splitright = true
-- Searches wrap around end-of-life.
o.wrapscan = true
-- Always report changed lines.
o.report = 0
-- Only highlight the first 200 columns.
o.synmaxcol = 200
-- Show invisible characters.
o.list = true
-- Enable code folding
o.foldmethod = 'syntax'
-- Disable code folding by default
o.foldenable = false
-- Command timeout
o.ttimeoutlen = 50
-- Mapping timeout
o.timeoutlen = 200
-- Swapfile write time
o.updatetime = 300
-- Don't pass messages to |ins-completion-menu|.
opt.shortmess:append({ c = true })
-- Show incremental live substitution
o.inccommand = 'nosplit'
-- Show line numbers
o.number = true
-- Do not show default statusline
o.showmode = false
-- Enable mouse integration for all modes
o.mouse = 'a'
-- Disable always visible command line
o.cmdheight = 0

-- Invisible characters
if vim.fn.has('multi_byte') and o.encoding == 'utf-8' then
  o.listchars = 'tab:▸ ,extends:❯,precedes:❮,nbsp:±,trail:•'
else
  o.listchars = 'tab:> ,extends:>,precedes:<,nbsp:.,trail:~'
end

-- Spell check settings
o.spelllang = 'en'
o.spellfile = (env.DOTLIB or '') .. '/spell/en.utf-8.add'
-- The following is from https://stackoverflow.com/a/38742983/355325
cmd([[
  for d in glob("$DOTLIB/spell/*.add", 1, 1)
    if filereadable(d) && (!filereadable(d . '.spl') || getftime(d) > getftime(d . '.spl'))
      exec 'mkspell! ' . fnameescape(d)
    endif
  endfor
]])

local mouse_focus_augroup = vim.api.nvim_create_augroup('MouseFocus', { clear = true })
vim.api.nvim_create_autocmd(
  'FocusGained',
  {
    callback = function()
      o.mouse = 'a'
    end,
    group = mouse_focus_augroup,
  }
)

vim.api.nvim_create_autocmd(
  'FocusLost',
  {
    callback = function()
      o.mouse = ''
    end,
    group = mouse_focus_augroup
  }
)
