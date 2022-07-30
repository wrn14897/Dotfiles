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
  set tags=./tags,tags;$HOME
" }

" Plugin List (vim-plug) {
  call plug#begin('~/.vim/plugged')
  if has('nvim')
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'kevinhwang91/nvim-bqf'
    Plug 'antoinemadec/coc-fzf'
    Plug 'lukas-reineke/indent-blankline.nvim'
  endif
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'airblade/vim-rooter'
  Plug 'mileszs/ack.vim'
  Plug 'romainl/vim-qf'
  Plug 'flazz/vim-colorschemes'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rhubarb'
  Plug 'junegunn/gv.vim'
  Plug 'jiangmiao/auto-pairs'
  Plug 'rhysd/conflict-marker.vim'
  Plug 'powerline/fonts'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'tpope/vim-commentary'
  Plug 'preservim/nerdtree', { 'on': ['NERDTreeToggle'] }
  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'mbbill/undotree'
  Plug 'godlygeek/tabular'
  Plug 'wellle/targets.vim'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-repeat'
  Plug 'mhinz/vim-signify'
  Plug 'preservim/tagbar'
  Plug 'christoomey/vim-sort-motion'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'edkolev/tmuxline.vim'
  Plug 'gko/vim-coloresque'
  Plug 'michaeljsmith/vim-indent-object'
  Plug 'kana/vim-textobj-user'
  Plug 'preservim/vim-textobj-sentence'
  Plug 'powerman/vim-plugin-AnsiEsc'
  Plug 'preservim/vimux'
  Plug 'mhinz/vim-startify'
  Plug 'dstein64/vim-startuptime'
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
  nnoremap tt  :tabedit<return>:CocCommand fzf-preview.FromResources project_mru git<CR>
  nnoremap tw  :tabclose<return>

  inoremap jk <esc>
  inoremap <esc> <nop>

  
  " Yank from the cursor to the end of the line, to be consistent with C and D.
  nnoremap Y y$

  " Find merge conflict markers
  map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>

  " For when you forget to sudo.. Really Write the file.
  cmap w!! w !sudo tee % >/dev/null

  " Easier horizontal scrolling
  noremap zl zL
  noremap zh zH

  " Edit/Source vimrc file
  nnoremap <leader>ev :vsplit $MYVIMRC<CR>
  nnoremap <leader>sv :source $MYVIMRC<CR>

  " Cursor
  let &t_SI = "\<Esc>[6 q"
  let &t_SR = "\<Esc>[4 q"
  let &t_EI = "\<Esc>[2 q"

  " Macro
  xnoremap <silent> . :normal .<CR>
" }

" Snippets {
  nnoremap ,html :-1read $HOME/.vim/snippets/html<CR>3j2f<i
" }

" Plugin Configs {
  " Coc {
    let g:coc_global_extensions = [
          \ 'coc-eslint',
          \ 'coc-prettier',
          \ 'coc-clangd',
          \ 'coc-css',
          \ 'coc-diagnostic',
          \ 'coc-fzf-preview',
          \ 'coc-go',
          \ 'coc-html',
          \ 'coc-json',
          \ 'coc-markdownlint',
          \ 'coc-phpls',
          \ 'coc-pyright',
          \ 'coc-sh',
          \ 'coc-solargraph',
          \ 'coc-tsserver'
          \ ]
    nmap <silent> <C-j> <Plug>(coc-diagnostic-next)
    nmap <silent> <C-k> <Plug>(coc-diagnostic-prev)
    command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')
  " }

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
    let $FZF_DEFAULT_OPTS = '--layout=reverse --info=inline'
    let $FZF_DEFAULT_COMMAND="rg --files --hidden"
  " }

  " fzf.vim {
    let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } }

    " Advanced ripgrep integration
    function! RipgrepFzf(query, fullscreen)
      let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
      let initial_command = printf(command_fmt, shellescape(a:query))
      let reload_command = printf(command_fmt, '{q}')
      let spec = {'options': '--delimiter : --nth 4..'}
      call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
    endfunction

    command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
    nnoremap <c-f> :Rg<CR>
  " }

  " fzf-preview {
    let g:fzf_preview_command = 'bat --theme=gruvbox-dark --color=always --plain {-1}'

    nnoremap <c-p> :CocCommand fzf-preview.ProjectFiles<CR>

    nmap <Leader>f [fzf-p]
    xmap <Leader>f [fzf-p]

    nnoremap <silent> [fzf-p]b :<C-u>CocCommand fzf-preview.Buffers<CR>
    nnoremap <silent> [fzf-p]m :<C-u>CocCommand fzf-preview.Marks<CR>
    nnoremap <silent> [fzf-p]/ :<C-u>CocCommand fzf-preview.Lines --add-fzf-arg=--no-sort --add-fzf-arg=--query="'"<CR>
    nnoremap <silent> <Leader>gl :<C-u>CocCommand fzf-preview.GitLogs<CR>

    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)
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

  " Signify {
    " Faster sign updates on CursorHold/CursorHoldI
    set updatetime=100
    nnoremap <leader>gu :SignifyHunkUndo<CR>
  " }

  " Fugitive {
    nnoremap <silent> <leader>gs :Git<CR>
    nnoremap <silent> <leader>gd :Gvdiffsplit<CR>
    nnoremap <silent> <leader>gc :Git commit<CR>
    nnoremap <silent> <leader>gb :Git blame<CR>
    " nnoremap <silent> <leader>gl :Gclog<CR>
    " nnoremap <silent> <leader>gp :Git push<CR>
    nnoremap <silent> <leader>gr :Gread<CR>
    nnoremap <silent> <leader>gw :Gwrite<CR>
    nnoremap <silent> <leader>ge :Gedit<CR>
    nnoremap <silent> <leader>gi :Git add -p %<CR>
    " Open visual selection in the browser
    vnoremap <Leader>gb :Gbrowse<CR>
  " }

  " ALE {
    " let g:ale_disable_lsp = 1
    " let g:ale_sign_error = '✘'
    " let g:ale_sign_warning = '⚠'
    " highlight ALEErrorSign ctermbg=NONE ctermfg=red
    " highlight ALEWarningSign ctermbg=NONE ctermfg=yellow
    " let g:ale_echo_msg_error_str = 'E'
    " let g:ale_echo_msg_warning_str = 'W'
    " let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
    " let g:ale_python_flake8_executable = 'python3'
    " let g:ale_python_flake8_options = '-m flake8'
    " let g:ale_linters = {}
    " let g:ale_linters.typescript = ['eslint', 'tsserver']
    " let g:ale_javascript_eslint_executable = 'eslint_d --cache'
    " let g:ale_typescript_prettier_use_local_config = 1
    " nmap <silent> <C-k> <Plug>(ale_previous_wrap)
    " nmap <silent> <C-j> <Plug>(ale_next_wrap)
  " }

  " TagBar {
    nnoremap <silent> <leader>tt :TagbarToggle<CR>
  " }

  " Rainbow {
    let g:rainbow_active = 1
  " }

  " Airline {
    let g:airline_theme = 'base16_gruvbox_dark_hard'
    let g:airline_powerline_fonts = 1
    " let g:airline#extensions#ale#enabled = 1
    let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
    if !exists('g:airline_symbols')
      let g:airline_symbols = {}
    endif
    let g:airline_symbols.colnr = ':'
    let g:airline_symbols.maxlinenr = ''
  " }

  " GoLang {
    " let g:go_version_warning = 0
    " autocmd FileType go nmap <leader>b  <Plug>(go-build)
    " autocmd FileType go nmap <leader>r  <Plug>(go-run)
    " autocmd FileType go nmap <leader>t  <Plug>(go-test)
    " let g:go_fmt_command = "goimports"
  " }

  " vimux {
    map <Leader>vp :VimuxPromptCommand<CR>
    map <Leader>vs :VimuxInterruptRunner<CR>
    map <Leader>vl :VimuxRunLastCommand<CR>
  " }
" }
