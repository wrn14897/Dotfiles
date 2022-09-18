--- TODO: Migrate this to lua
vim.cmd([[
" General {
  filetype plugin indent on   " Automatically detect file types.
  syntax on                   " Syntax highlighting

  if has('clipboard')
    if has('unnamedplus')  " When possible use + register for copy-paste
      set clipboard=unnamed,unnamedplus
    else         " On mac and Windows, use * register for copy-paste
      set clipboard=unnamed
    endif
  endif

  set directory^=$HOME/.vim/swap//
  set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
" }

" UI {
  highlight clear SignColumn      " SignColumn should match background
  highlight clear LineNr          " Current line number row will have same background color in relative mode

  if has('cmdline_info')
    set ruler                   " Show the ruler
    set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
    set showcmd                 " Show partial commands in status line and
    " Selected characters/lines in visual mode
  endif

  if has('statusline')
    set laststatus=2
    " Broken down into easily includeable segments
    set statusline=%<%f\                     " Filename
    set statusline+=%w%h%m%r                 " Options
    set statusline+=%{fugitive#statusline()} " Git Hotness
    set statusline+=\ [%{&ff}/%Y]            " Filetype
    set statusline+=\ [%{getcwd()}]          " Current dir
    set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
  endif
" }
]])

--- General
vim.g.mapleader = ','
vim.o.t_SI = "<Esc>[6 q"
vim.o.t_SR = "<Esc>[4 q"
vim.o.t_EI = "<Esc>[2 q"

vim.opt.encoding = "utf-8"
vim.opt.mousehide = true
vim.opt.shortmess :append('filmnrxoOtT') --- Abbrev. of messages (avoids 'hit enter')
vim.opt.viewoptions = "folds,options,cursor,unix,slash" --- Better Unix / Windows compatibility
vim.opt.virtualedit = "onemore" --- Allow for cursor beyond last character
vim.opt.history = 1000 --- Store a ton of history (default is 20)
vim.opt.spell = true --- Spell checking on 
vim.opt.hidden = true --- Allow buffer switching without saving
vim.opt.iskeyword:remove({'.', '#', '-'})
vim.opt.tags = "./tags,tags;$HOME"

--- UI 
vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[ colorscheme gruvbox ]])
vim.opt.tabpagemax = 15 --- Only show 15 tabs
vim.opt.showmode = true --- Display the current mode
vim.opt.cursorline = true --- Highlight current line

vim.opt.backspace = "indent,eol,start" --- Backspace for dummies
vim.opt.linespace = 0 --- No extra spaces between rows
vim.opt.number = true --- Line numbers on
vim.opt.showmatch = true --- Show matching brackets/parenthesis
vim.opt.incsearch = true --- Find as you type search
vim.opt.hlsearch = true --- Highlight search terms
vim.opt.winminheight = 0 --- Windows can be 0 line high
vim.opt.ignorecase = true --- Case insensitive search
vim.opt.smartcase = true --- Case sensitive when uc present
vim.opt.wildmenu = true --- Show list instead of just completing
vim.opt.wildmode = "list:longest,full" --- Command <Tab> completion, list matches, then longest common part, then all.
vim.opt.whichwrap = "b,s,h,l,<,>,[,]" --- Backspace and cursor keys wrap too
vim.opt.scrolljump = 5 --- Lines to scroll when cursor leaves screen
vim.opt.scrolloff = 3 --- Minimum lines to keep above and below cursor
vim.opt.foldenable = true --- Auto fold code
vim.opt.list = true

--- Formatting
vim.opt.wrap = false --- Do not wrap long lines
vim.opt.autoindent = true --- Indent at the same level of the previous line
vim.opt.shiftwidth = 2 --- Use indents of 4 spaces
vim.opt.expandtab = true --- Tabs are spaces, not tabs
vim.opt.tabstop = 2 --- An indentation every four columns
vim.opt.softtabstop = 2 --- Let backspace delete indent
vim.opt.joinspaces = false --- Prevents inserting two spaces after punctuation on a join (J)
vim.opt.splitright = true --- Puts new vsplit windows to the right of the current
vim.opt.splitbelow = true --- Puts new split windows to the bottom of the current
