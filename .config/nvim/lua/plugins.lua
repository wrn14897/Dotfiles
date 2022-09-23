local utils = require('utils')

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  use 'ryanoasis/vim-devicons'

  use 'andymass/vim-matchup'

  use 'kevinhwang91/nvim-bqf'

  use 'antoinemadec/coc-fzf'

  use 'lukas-reineke/indent-blankline.nvim'

  use {
    'neoclide/coc.nvim',
    branch = 'release'
  }

  use 'airblade/vim-rooter'

  use 'mileszs/ack.vim'

  use 'romainl/vim-qf'

  use 'flazz/vim-colorschemes'

  use 'tpope/vim-fugitive'

  use 'tpope/vim-rhubarb'

  use 'junegunn/gv.vim'

  use 'jiangmiao/auto-pairs'

  use 'rhysd/conflict-marker.vim'

  use 'powerline/fonts'

  use {'junegunn/fzf', run = function()
    vim.fn['fzf#install']()
  end
  }

  use 'junegunn/fzf.vim'

  use 'tpope/vim-commentary'

  use {
    'preservim/nerdtree',
    cmd = {'NERDTreeToggle', 'NERDTreeFind'}
  }

  use 'Xuyuanp/nerdtree-git-plugin'

  use 'mbbill/undotree'

  use 'godlygeek/tabular'

  use 'wellle/targets.vim'

  use 'tpope/vim-surround'

  use 'tpope/vim-repeat'

  use 'mhinz/vim-signify'

  use 'preservim/tagbar'

  use 'christoomey/vim-sort-motion'

  use 'gko/vim-coloresque'

  use 'michaeljsmith/vim-indent-object'

  use 'kana/vim-textobj-user'

  use 'preservim/vim-textobj-sentence'

  use 'powerman/vim-plugin-AnsiEsc'

  use 'lewis6991/impatient.nvim'

  use 'preservim/vimux'

  use {
    'goolord/alpha-nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function ()
      require'alpha'.setup(require'alpha.themes.startify'.config)
    end
  }

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  --- ********************************************
  --- ************ Plugin Setups ****************
  --- ********************************************
  --- lualine
  require('lualine').setup {
    options = {
      icons_enabled = true,
      theme = 'gruvbox_dark',
      component_separators = { left = '', right = ''},
      section_separators = { left = '', right = ''},
      disabled_filetypes = {
        statusline = {},
        winbar = {},
      },
      ignore_focus = {},
      always_divide_middle = true,
      globalstatus = false,
      refresh = {
        statusline = 1000,
        tabline = 1000,
        winbar = 1000,
      }
    },
    sections = {
      lualine_a = {'mode'},
      lualine_b = {'branch', 'diff', 'diagnostics'},
      lualine_c = {'filename'},
      lualine_x = {'encoding', 'fileformat', 'filetype'},
      lualine_y = {'progress'},
      lualine_z = {'location'}
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {'filename'},
      lualine_x = {'location'},
      lualine_y = {},
      lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {'quickfix', 'nerdtree', 'fugitive'}
  }
  
  --- nvim-treesitter
  require('nvim-treesitter.configs').setup {
    -- One of "all", "maintained" (parsers with maintainers), or a list of languages
    ensure_installed = "all",

    -- Install languages synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- List of parsers to ignore installing
    ignore_install = {},

    highlight = {
      -- `false` will disable the whole extension
      enable = true,

      -- list of language that will be disabled
      disable = {},

      -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
      -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
      -- Using this option may slow down your editor, and you may see some duplicate highlights.
      -- Instead of true it can also be a list of languages
      additional_vim_regex_highlighting = false,
    },
    rainbow = {
      enable = true,
      -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
      extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
      max_file_lines = nil, -- Do not enable for files with more than n lines, int
      -- colors = {}, -- table of hex strings
      -- termcolors = {} -- table of colour name strings
    },
    matchup = {
      enable = true
    },
  }

  --- indent_blankline
  require('indent_blankline').setup()

  --- ********************************************
  --- ************ Plugin Configs ****************
  --- ********************************************
  --- Nerdtree
  utils.nmap('<C-e>', ':NERDTreeToggle<CR>')
  utils.nmap('<leader>nf', ':NERDTreeFind<CR>')
  vim.g.nerdtree_tabs_open_on_gui_startup = 0
  vim.cmd([[
    let NERDTreeShowBookmarks=1
    let NERDTreeChDirMode=0
    let NERDTreeQuitOnOpen=1
    let NERDTreeMouseMode=2
    let NERDTreeShowHidden=1
    let NERDTreeKeepTreeInNewTab=1
  ]])

  --- Coc
  vim.g.coc_global_extensions = {
    'coc-clangd',
    'coc-css',
    'coc-diagnostic',
    'coc-eslint',
    'coc-fzf-preview',
    'coc-git',
    'coc-go',
    'coc-html',
    'coc-json',
    'coc-markdownlint',
    'coc-phpls',
    'coc-prettier',
    'coc-pyright',
    'coc-rust-analyzer',
    'coc-sh',
    'coc-solargraph',
    'coc-sumneko-lua',
    'coc-tsserver'
  }
  utils.nmap('<C-j>', '<Plug>(coc-diagnostic-next)')
  utils.nmap('<C-k>', '<Plug>(coc-diagnostic-prev)')

  --- NOTE: Requires 'textDocument.documentSymbol' support from the language server.
  utils.xmap('if', '<Plug>(coc-funcobj-i)')
  utils.omap('if', '<Plug>(coc-funcobj-i)')
  utils.xmap('af', '<Plug>(coc-funcobj-a)')
  utils.omap('af', '<Plug>(coc-funcobj-a)')
  utils.xmap('ic', '<Plug>(coc-classobj-i)')
  utils.omap('ic', '<Plug>(coc-classobj-i)')
  utils.xmap('ac', '<Plug>(coc-classobj-a)')
  utils.omap('ac', '<Plug>(coc-classobj-a)')
  vim.cmd([[
    command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')
  ]])

  --- Rooter
  vim.g.rooter_patterns = {'.git'}

  --- Ack
  vim.cmd([[
    if executable('rg')
      let g:ackprg = 'rg -S --no-heading --vimgrep'
    elseif executable('ag')
      let g:ackprg = 'ag --vimgrep'
    endif
    cnoreabbrev Ack Ack!
  ]])
  utils.nmap('<leader>a', ':Ack<Space>')

  --- fzf
  vim.env.FZF_DEFAULT_OPTS = '--layout=reverse --info=inline'
  vim.env.FZF_DEFAULT_COMMAND = 'rg --files --hidden'
  --- fzf.vim
  local fzf_layout = {}
  fzf_layout.window = {}
  fzf_layout.window.height = 0.9
  fzf_layout.window.width = 0.9
  vim.g.fzf_layout = fzf_layout
  vim.cmd([[
    " Advanced ripgrep integration
    function! RipgrepFzf(query, fullscreen)
      let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
      let initial_command = printf(command_fmt, shellescape(a:query))
      let reload_command = printf(command_fmt, '{q}')
      let spec = {'options': '--delimiter : --nth 4..'}
      call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
    endfunction

    command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
  ]])
  utils.nmap('<c-f>', ':Rg<CR>')
  utils.nmap('<c-p>', ':Files<CR>')
  --- fzf-preview
  vim.g.fzf_preview_command = 'bat --theme=gruvbox-dark --color=always --plain {-1}'
  utils.nmap('<Leader>fb', ':<C-u>CocCommand fzf-preview.Buffers<CR>')
  utils.nmap('<Leader>fm', ':<C-u>CocCommand fzf-preview.Marks<CR>')
  utils.nmap('<Leader>f/', ':<C-u>CocCommand fzf-preview.Lines --add-fzf-arg=--no-sort --add-fzf-arg=--query="\'"<CR>')
  utils.nmap('<Leader>gl', ':<C-u>CocCommand fzf-preview.GitLogs<CR>')
  utils.nmap('gd', '<Plug>(coc-definition)')
  utils.nmap('gy', '<Plug>(coc-type-definition)')
  utils.nmap('gi', '<Plug>(coc-implementation)')
  utils.nmap('gr', '<Plug>(coc-references)')

  --- Signify
  -- Faster sign updates on CursorHold/CursorHoldI
  vim.opt.updatetime = 100
  utils.nmap('<leader>gu', ':SignifyHunkUndo<CR>')

  --- Fugitive
  utils.nmap('<leader>gs', ':Git<CR>')
  utils.nmap('<leader>gd', ':Gvdiffsplit<CR>')
  utils.nmap('<leader>gc', ':Git commit<CR>')
  utils.nmap('<leader>gb', ':Git blame<CR>')
  -- nnoremap <silent> <leader>gl :Gclog<CR>
  -- nnoremap <silent> <leader>gp :Git push<CR>
  utils.nmap('<leader>gr', ':Gread<CR>')
  utils.nmap('<leader>gw', ':Gwrite<CR>')
  utils.nmap('<leader>ge', ':Gedit<CR>')
  utils.nmap('<leader>gi', ':Git add -p %<CR>')
  -- Open visual selection in the browser
  utils.vmap('br', ':GBrowse<CR>')
  utils.vmap('b', ':GV<CR>')

  --- TagBar
  utils.nmap('<leader>tt', ':TagbarToggle<CR>')

  --- vimux
  utils.nmap('<Leader>vp', ':VimuxPromptCommand<CR>');
  utils.nmap('<Leader>vs', ':VimuxInterruptRunner<CR>');
  utils.nmap('<Leader>vl', ':VimuxRunLastCommand<CR>');
end)

