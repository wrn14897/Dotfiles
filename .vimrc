" General {
  set background=dark         " Assume a dark background

  filetype plugin indent on   " Automatically detect file types.
  syntax on                   " Syntax highlighting
  set mousehide               " Hide the mouse cursor while typing
  scriptencoding utf-8

  if has('clipboard')
    if has('unnamedplus')  " When possible use + register for copy-paste
      set clipboard=unnamed,unnamedplus
    else         " On mac and Windows, use * register for copy-paste
      set clipboard=unnamed
    endif
  endif

  set shortmess+=filmnrxoOtT          " Abbrev. of messages (avoids 'hit enter')
  set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
  set virtualedit=onemore             " Allow for cursor beyond last character
  set history=1000                    " Store a ton of history (default is 20)
  set spell                           " Spell checking on
  set hidden                          " Allow buffer switching without saving
  set iskeyword-=.                    " '.' is an end of word designator
  set iskeyword-=#                    " '#' is an end of word designator
  set iskeyword-=-                    " '-' is an end of word designator

  set directory^=$HOME/.vim/swap//
" }


" Plugin List (vim-plug) {
  call plug#begin('~/.vim/plugged')
  Plug 'airblade/vim-rooter'
  Plug 'mileszs/ack.vim'
  Plug 'romainl/vim-qf'
  Plug 'flazz/vim-colorschemes'
  Plug 'tpope/vim-fugitive'
  Plug 'junegunn/gv.vim'
  Plug 'fatih/vim-go'
  Plug 'dense-analysis/ale'
  Plug 'jiangmiao/auto-pairs'
  Plug 'rhysd/conflict-marker.vim'
  Plug 'nathanaelkane/vim-indent-guides'
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
  Plug 'Shougo/neosnippet.vim'
  Plug 'Shougo/neosnippet-snippets'
  Plug 'powerline/fonts'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'yuezk/vim-js'
  Plug 'maxmellon/vim-jsx-pretty'
  Plug 'leafgarland/typescript-vim'
  Plug 'peitalin/vim-jsx-typescript'
  Plug 'elzr/vim-json'
  Plug 'tpope/vim-commentary'
  Plug 'preservim/nerdtree'
  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
  Plug 'mbbill/undotree'
  Plug 'godlygeek/tabular'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-repeat'
  Plug 'luochen1990/rainbow'
  Plug 'mhinz/vim-signify'
  Plug 'preservim/tagbar'
  Plug 'christoomey/vim-sort-motion'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'gko/vim-coloresque'
  Plug 'michaeljsmith/vim-indent-object'
  Plug 'kana/vim-textobj-user'
  Plug 'preservim/vim-textobj-sentence'
  call plug#end()
" }


" UI {
  colorscheme gruvbox
  set tabpagemax=15               " Only show 15 tabs
  set showmode                    " Display the current mode
  set cursorline                  " Highlight current line
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

  set backspace=indent,eol,start  " Backspace for dummies
  set linespace=0                 " No extra spaces between rows
  set number relativenumber       " Line numbers on
  set showmatch                   " Show matching brackets/parenthesis
  set incsearch                   " Find as you type search
  set hlsearch                    " Highlight search terms
  set winminheight=0              " Windows can be 0 line high
  set ignorecase                  " Case insensitive search
  set smartcase                   " Case sensitive when uc present
  set wildmenu                    " Show list instead of just completing
  set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
  set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
  set scrolljump=5                " Lines to scroll when cursor leaves screen
  set scrolloff=3                 " Minimum lines to keep above and below cursor
  set foldenable                  " Auto fold code
  set list
  set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
" }

" Formatting {
  set nowrap                      " Do not wrap long lines
  set autoindent                  " Indent at the same level of the previous line
  set shiftwidth=2                " Use indents of 4 spaces
  set expandtab                   " Tabs are spaces, not tabs
  set tabstop=2                   " An indentation every four columns
  set softtabstop=2               " Let backspace delete indent
  set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
  set splitright                  " Puts new vsplit windows to the right of the current
  set splitbelow                  " Puts new split windows to the bottom of the current
" }

" Key Mappings {
  let mapleader = ','
  " Wrapped lines goes down/up to next row, rather than next line in file.
  noremap j gj
  noremap k gk
  nnoremap <C-c> :noh<return><C-c>
  nnoremap H gT
  nnoremap L gt
  nnoremap tt  :tabedit<return>:Files<CR>
  nnoremap tw  :tabclose<return>

  " Yank from the cursor to the end of the line, to be consistent with C and D.
  nnoremap Y y$

  " Find merge conflict markers
  map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>

  " For when you forget to sudo.. Really Write the file.
  cmap w!! w !sudo tee % >/dev/null

  " Easier horizontal scrolling
  map zl zL
  map zh zH

  " Cursor
  let &t_SI = "\<Esc>[6 q"
  let &t_SR = "\<Esc>[4 q"
  let &t_EI = "\<Esc>[2 q"
" }

" Plugin Configs {
  " Rooter {
    let g:rooter_patterns = ['.git']
  " }
  " Ack {
    if executable('rg')
      let g:ackprg = 'rg -S --no-heading --vimgrep'
    elseif executable('ag')
      let g:ackprg = 'ag --vimgrep'
    endif
    cnoreabbrev Ack Ack!
    map <leader>a :Ack<Space>
  " }

  " fzf {
    let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } }
    " let $FZF_DEFAULT_OPTS="--ansi --preview-window 'right:50%' --layout reverse --margin=1,4 --preview 'bat --color=always --style=header,grid --line-range :300 {}'"
    let $FZF_DEFAULT_OPTS = '--layout=reverse --info=inline'
    let $FZF_DEFAULT_COMMAND="rg --files --hidden"
    nnoremap <c-p> :GFiles<CR>
    nnoremap <c-f> :Rg<CR>
    nnoremap <Leader>b :Buffers<CR>
    nnoremap <Leader>s :BLines<CR>

    " Advanced ripgrep integration
    function! RipgrepFzf(query, fullscreen)
      let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
      let initial_command = printf(command_fmt, shellescape(a:query))
      let reload_command = printf(command_fmt, '{q}')
      let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
      call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
    endfunction

    command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
  " }

  " Nerdtree {
    nnoremap <C-e> :NERDTreeToggle<CR>
    let NERDTreeShowBookmarks=1
    let NERDTreeChDirMode=0
    let NERDTreeQuitOnOpen=1
    let NERDTreeMouseMode=2
    let NERDTreeShowHidden=1
    let NERDTreeKeepTreeInNewTab=1
    let g:nerdtree_tabs_open_on_gui_startup=0
  " }

  " Fugitive {
    nnoremap <silent> <leader>gs :Git<CR>
    nnoremap <silent> <leader>gd :Gvdiffsplit<CR>
    nnoremap <silent> <leader>gc :Git commit<CR>
    nnoremap <silent> <leader>gb :Git blame<CR>
    nnoremap <silent> <leader>gl :Gclog<CR>
    nnoremap <silent> <leader>gp :Git push<CR>
    nnoremap <silent> <leader>gr :Gread<CR>
    nnoremap <silent> <leader>gw :Gwrite<CR>
    nnoremap <silent> <leader>ge :Gedit<CR>
    nnoremap <silent> <leader>gi :Git add -p %<CR>
    nnoremap <silent> <leader>gg :SignifyToggle<CR>
  " }

  " deoplete {
    let g:deoplete#enable_at_startup = 1
    " <TAB>: completion.
    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
  " }

  " ALE {
    let g:ale_sign_error = '✘'
    let g:ale_sign_warning = '⚠'
    highlight ALEErrorSign ctermbg=NONE ctermfg=red
    highlight ALEWarningSign ctermbg=NONE ctermfg=yellow
    let g:ale_echo_msg_error_str = 'E'
    let g:ale_echo_msg_warning_str = 'W'
    let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
    let g:ale_python_flake8_executable = 'python3'
    let g:ale_python_flake8_options = '-m flake8'
    let g:ale_linters = {}
    let g:ale_linters.typescript = ['eslint', 'tsserver']
    let g:ale_javascript_eslint_executable = 'eslint_d --cache'
    let g:ale_typescript_prettier_use_local_config = 1
    nmap <silent> <C-k> <Plug>(ale_previous_wrap)
    nmap <silent> <C-j> <Plug>(ale_next_wrap)
  " }

  " TagBar {
    nnoremap <silent> <leader>tt :TagbarToggle<CR>
  " }

  " Rainbow {
    let g:rainbow_active = 1
  " }

  " Airline {
    let g:airline_theme = 'base16_gruvbox_dark_hard'
    let g:airline_left_sep='›'
    let g:airline_right_sep='‹'
    let g:airline#extensions#ale#enabled = 1
  " }

  " GoLang {
    let g:go_version_warning = 0
    autocmd FileType go nmap <leader>b  <Plug>(go-build)
    autocmd FileType go nmap <leader>r  <Plug>(go-run)
    autocmd FileType go nmap <leader>t  <Plug>(go-test)
    let g:go_fmt_command = "goimports"
  " }

" }
