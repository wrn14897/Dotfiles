local utils = require("utils")

-- Automatically source and re-compile packer whenever you save this file
vim.cmd(
  [[
    augroup packer_user_config
      autocmd!
      autocmd BufWritePost plugins.lua source <afile> | PackerCompile
    augroup end
  ]]
)

require("packer").startup(
  function(use)
    -- Packer can manage itself
    use "wbthomason/packer.nvim"

    use {
      -- LSP Configuration & Plugins
      "neovim/nvim-lspconfig",
      requires = {
        -- Automatically install LSPs to stdpath for neovim
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        -- Useful status updates for LSP
        "j-hui/fidget.nvim"
      }
    }

    use {
      -- Autocompletion
      "hrsh7th/nvim-cmp",
      requires = {"hrsh7th/cmp-nvim-lsp", "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip"}
    }

    use {
      -- Highlight, edit, and navigate code
      "nvim-treesitter/nvim-treesitter",
      run = function()
        pcall(require("nvim-treesitter.install").update {with_sync = true})
      end
    }

    use {
      -- Additional text objects via treesitter
      "nvim-treesitter/nvim-treesitter-textobjects",
      after = "nvim-treesitter"
    }

    use "folke/lsp-colors.nvim"

    use "ryanoasis/vim-devicons"

    use "andymass/vim-matchup"

    use "kevinhwang91/nvim-bqf"

    use "lukas-reineke/indent-blankline.nvim"

    use "airblade/vim-rooter"

    use "romainl/vim-qf"

    use "flazz/vim-colorschemes"

    use "tpope/vim-fugitive"

    use "lewis6991/gitsigns.nvim"

    use "junegunn/gv.vim"

    use "tpope/vim-rhubarb"

    use "jiangmiao/auto-pairs"

    use "rhysd/conflict-marker.vim"

    use "powerline/fonts"

    use {
      "junegunn/fzf",
      run = function()
        vim.fn["fzf#install"]()
      end
    }

    use {
      "ibhagwan/fzf-lua",
      -- optional for icon support
      requires = {"kyazdani42/nvim-web-devicons"}
    }

    use "tpope/vim-commentary"

    use {
      "preservim/nerdtree",
      cmd = {"NERDTreeToggle", "NERDTreeFind"}
    }

    use "Xuyuanp/nerdtree-git-plugin"

    use "mbbill/undotree"

    use "godlygeek/tabular"

    use "wellle/targets.vim"

    use "tpope/vim-surround"

    use "tpope/vim-repeat"

    use "preservim/tagbar"

    use "christoomey/vim-sort-motion"

    use "gko/vim-coloresque"

    use "michaeljsmith/vim-indent-object"

    use "kana/vim-textobj-user"

    use "preservim/vim-textobj-sentence"

    use "powerman/vim-plugin-AnsiEsc"

    use "lewis6991/impatient.nvim"

    use "preservim/vimux"

    use {
      "goolord/alpha-nvim",
      requires = {"kyazdani42/nvim-web-devicons"},
      config = function()
        require "alpha".setup(require "alpha.themes.startify".config)
      end
    }

    use {
      "nvim-lualine/lualine.nvim",
      requires = {"kyazdani42/nvim-web-devicons", opt = true}
    }

    use {"mhartington/formatter.nvim"}

    use {
      "folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons"
    }

    --- ********************************************
    --- ************ Plugin Setups ****************
    --- ********************************************
    --- fzf-lua
    require "fzf-lua".setup {
      winopts = {
        height = 0.9,
        width = 0.9
      },
      previewers = {
        git_diff = {
          pager = "delta --width=$FZF_PREVIEW_COLUMNS"
        }
      },
      keymap = {
        fzf = {
          ["ctrl-z"] = "abort",
          ["ctrl-k"] = "unix-line-discard",
          ["ctrl-d"] = "preview-page-down",
          ["ctrl-u"] = "preview-page-up"
        }
      },
      git = {
        commits = {
          preview_pager = "delta --width=$FZF_PREVIEW_COLUMNS"
        },
        bcommits = {
          preview_pager = "delta --width=$FZF_PREVIEW_COLUMNS"
        }
      }
    }
    utils.nmap("<c-f>", ":FzfLua grep_project<CR>")
    utils.nmap("<c-p>", ":FzfLua files<CR>")
    utils.nmap("<Leader>fw", ":FzfLua grep_cword<CR>")
    utils.nmap("<Leader>fb", ":FzfLua buffers<CR>")
    utils.nmap("<Leader>fm", ":FzfLua marks<CR>")
    utils.nmap("<Leader>fr", ":FzfLua registers<CR>")
    utils.nmap("<Leader>f/", ":FzfLua lines<CR>")
    utils.nmap("<Leader>ft", ":FzfLua tabs<CR>")
    utils.nmap("<Leader>gl", ":FzfLua git_commits<CR>")
    utils.nmap("<Leader>gbl", ":FzfLua git_bcommits<CR>")

    --- Fugitive
    utils.nmap("<leader>gs", ":Git<CR>")
    utils.nmap("<leader>gd", ":Gvdiffsplit<CR>")
    utils.nmap("<leader>gc", ":Git commit<CR>")
    utils.nmap("<leader>gb", ":Git blame<CR>")
    -- nnoremap <silent> <leader>gl :Gclog<CR>
    -- nnoremap <silent> <leader>gp :Git push<CR>
    utils.nmap("<leader>gr", ":Gread<CR>")
    utils.nmap("<leader>gw", ":Gwrite<CR>")
    utils.nmap("<leader>ge", ":Gedit<CR>")
    utils.nmap("<leader>gi", ":Git add -p %<CR>")
    -- Open visual selection in the browser
    utils.vmap("br", ":GBrowse<CR>")
    utils.vmap("b", ":GV<CR>")

    --- lualine
    require("lualine").setup {
      options = {
        icons_enabled = true,
        theme = "gruvbox_dark",
        component_separators = {left = "", right = ""},
        section_separators = {left = "", right = ""},
        disabled_filetypes = {
          statusline = {},
          winbar = {}
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000
        }
      },
      sections = {
        lualine_a = {"mode"},
        lualine_b = {"branch", "diff", "diagnostics"},
        lualine_c = {"filename"},
        lualine_x = {"encoding", "fileformat", "filetype"},
        lualine_y = {"progress"},
        lualine_z = {"location"}
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {"filename"},
        lualine_x = {"location"},
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {"quickfix", "nerdtree", "fugitive"}
    }

    --- nvim-treesitter
    require("nvim-treesitter.configs").setup {
      -- One of "all", "maintained" (parsers with maintainers), or a list of languages
      ensure_installed = {"go", "lua", "python", "rust", "typescript", "help"},
      -- Install languages synchronously (only applied to `ensure_installed`)
      sync_install = false,
      highlight = {enable = true},
      indent = {enable = true},
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<c-space>",
          node_incremental = "<c-space>",
          scope_incremental = "<c-s>",
          node_decremental = "<c-backspace>"
        }
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner"
          }
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            ["]m"] = "@function.outer",
            ["]]"] = "@class.outer"
          },
          goto_next_end = {
            --ignore-scripts
            ["]M"] = "@function.outer",
            ["]["] = "@class.outer"
          },
          goto_previous_start = {
            ["[m"] = "@function.outer",
            ["[["] = "@class.outer"
          },
          goto_previous_end = {
            ["[M"] = "@function.outer",
            ["[]"] = "@class.outer"
          }
        },
        swap = {
          enable = true,
          swap_next = {
            ["<leader>a"] = "@parameter.inner"
          },
          swap_previous = {
            ["<leader>A"] = "@parameter.inner"
          }
        }
      }
    }

    --- indent_blankline
    require("indent_blankline").setup()

    --- gitsigns
    require("gitsigns").setup {
      signs = {
        add = {hl = "GitSignsAdd", text = "│", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn"},
        change = {hl = "GitSignsChange", text = "│", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn"},
        delete = {hl = "GitSignsDelete", text = "_", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn"},
        topdelete = {hl = "GitSignsDelete", text = "‾", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn"},
        changedelete = {hl = "GitSignsChange", text = "~", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn"}
      },
      signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
      numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
      linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
      word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
      watch_gitdir = {
        interval = 1000,
        follow_files = true
      },
      attach_to_untracked = true,
      current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false
      },
      current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil, -- Use default
      max_file_length = 40000, -- Disable if file is longer than this (in lines)
      preview_config = {
        -- Options passed to nvim_open_win
        border = "single",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1
      },
      yadm = {
        enable = false
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map(
          "n",
          "]c",
          function()
            if vim.wo.diff then
              return "]c"
            end
            vim.schedule(
              function()
                gs.next_hunk()
              end
            )
            return "<Ignore>"
          end,
          {expr = true}
        )

        map(
          "n",
          "[c",
          function()
            if vim.wo.diff then
              return "[c"
            end
            vim.schedule(
              function()
                gs.prev_hunk()
              end
            )
            return "<Ignore>"
          end,
          {expr = true}
        )

        -- Actions
        map({"n", "v"}, "<leader>hs", ":Gitsigns stage_hunk<CR>")
        map({"n", "v"}, "<leader>hr", ":Gitsigns reset_hunk<CR>")
        map("n", "<leader>hS", gs.stage_buffer)
        map("n", "<leader>hu", gs.undo_stage_hunk)
        map("n", "<leader>hR", gs.reset_buffer)
        map("n", "<leader>hp", gs.preview_hunk)

        -- Text object
        map({"o", "x"}, "ih", ":<C-U>Gitsigns select_hunk<CR>")
      end
    }

    -- LSP settings.
    -- Diagnostic keymaps
    vim.keymap.set("n", "<C-k>", vim.diagnostic.goto_prev, {noremap = true, silent = true})
    vim.keymap.set("n", "<C-j>", vim.diagnostic.goto_next, {noremap = true, silent = true})

    local on_attach = function(_, bufnr)
      local nmap = function(keys, func)
        vim.keymap.set("n", keys, func, {buffer = bufnr, noremap = true, silent = true})
      end
      nmap("<leader>rn", vim.lsp.buf.rename)
      nmap("<leader>ca", vim.lsp.buf.code_action)

      nmap("gd", vim.lsp.buf.definition)
      nmap("gr", require("fzf-lua").lsp_references)
      nmap("gI", vim.lsp.buf.implementation)
      nmap("<leader>D", vim.lsp.buf.type_definition)
      nmap("<leader>ds", require("fzf-lua").lsp_document_symbols)
      nmap("<leader>ws", require("fzf-lua").lsp_live_workspace_symbols)

      -- See `:help K` for why this keymap
      nmap("K", vim.lsp.buf.hover)

      -- Create a command `:Format` local to the LSP buffer
      -- vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
      --   if vim.lsp.buf.format then
      --     vim.lsp.buf.format()
      --   elseif vim.lsp.buf.formatting then
      --     vim.lsp.buf.formatting()
      --   end
      -- end, { desc = 'Format current buffer with LSP' })
    end

    -- Setup mason so it can manage external tooling
    require("mason").setup()

    -- Enable the following language servers
    local servers = {
      "clangd",
      "rust_analyzer",
      "pyright",
      "tsserver",
      "sumneko_lua",
      "dockerls",
      "diagnosticls"
    }

    -- Ensure the servers above are installed
    require("mason-lspconfig").setup {
      ensure_installed = servers
    }

    -- nvim-cmp supports additional completion capabilities
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    for _, lsp in ipairs(servers) do
      require("lspconfig")[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities
      }
    end

    -- Turn on lsp status information
    require("fidget").setup()

    -- Make runtime files discoverable to the server
    local runtime_path = vim.split(package.path, ";")
    table.insert(runtime_path, "lua/?.lua")
    table.insert(runtime_path, "lua/?/init.lua")

    require("lspconfig").sumneko_lua.setup {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using (most likely LuaJIT)
            version = "LuaJIT",
            -- Setup your lua path
            path = runtime_path
          },
          diagnostics = {
            globals = {"vim"}
          },
          workspace = {library = vim.api.nvim_get_runtime_file("", true)},
          -- Do not send telemetry data containing a randomized but unique identifier
          telemetry = {enable = false}
        }
      }
    }

    require("lspconfig").diagnosticls.setup {
      on_attach = on_attach,
      capabilities = capabilities,
      filetypes = {"javascript", "javascriptreact", "typescript", "typescriptreact"},
      init_options = {
        filetypes = {
          javascript = "eslint",
          typescript = "eslint",
          javascriptreact = "eslint",
          typescriptreact = "eslint"
        },
        linters = {
          eslint = {
            sourceName = "eslint",
            command = "./node_modules/.bin/eslint",
            rootPatterns = {
              ".eslintrc",
              ".eslintrc.cjs",
              ".eslintrc.js",
              ".eslintrc.json",
              ".eslintrc.yaml",
              ".eslintrc.yml"
            },
            debounce = 100,
            args = {
              "--cache",
              "--stdin",
              "--stdin-filename",
              "%filepath",
              "--format",
              "json"
            },
            parseJson = {
              errorsRoot = "[0].messages",
              line = "line",
              column = "column",
              endLine = "endLine",
              endColumn = "endColumn",
              message = "[eslint] ${message} [${ruleId}]",
              security = "severity"
            },
            securities = {["1"] = "warning", ["2"] = "error"}
          }
        }
      }
    }

    -- nvim-cmp setup
    local cmp = require "cmp"
    local luasnip = require "luasnip"

    cmp.setup {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end
      },
      mapping = cmp.mapping.preset.insert {
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true
        },
        ["<Tab>"] = cmp.mapping(
          function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end,
          {"i", "s"}
        ),
        ["<S-Tab>"] = cmp.mapping(
          function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end,
          {"i", "s"}
        )
      },
      sources = {
        {name = "nvim_lsp"},
        {name = "luasnip"}
      }
    }

    --- Formatter
    local function format_prettier()
      return {
        exe = "npx",
        args = {"prettier", "--stdin-filepath", vim.api.nvim_buf_get_name(0)},
        stdin = true
      }
    end
    require("formatter").setup(
      {
        logging = true,
        filetype = {
          typescript = {format_prettier},
          typescriptreact = {format_prettier},
          javascript = {format_prettier},
          javascriptreact = {format_prettier},
          json = {format_prettier},
          lua = {
            -- luafmt
            function()
              return {
                exe = "npx",
                args = {"lua-fmt", "--indent-count", 2, "--stdin"},
                stdin = true
              }
            end
          }
        }
      }
    )

    --- Nerdtree
    utils.nmap("<C-e>", ":NERDTreeToggle<CR>")
    utils.nmap("<leader>nf", ":NERDTreeFind<CR>")
    vim.g.nerdtree_tabs_open_on_gui_startup = 0
    vim.cmd(
      [[
        let NERDTreeShowBookmarks=1
        let NERDTreeChDirMode=0
        let NERDTreeQuitOnOpen=1
        let NERDTreeMouseMode=2
        let NERDTreeShowHidden=1
        let NERDTreeKeepTreeInNewTab=1
      ]]
    )

    --- Trouble
    utils.nmap("<leader>xx", ":TroubleToggle<CR>")

    --- TagBar
    utils.nmap("<leader>tt", ":TagbarToggle<CR>")

    --- vimux
    utils.nmap("<Leader>vp", ":VimuxPromptCommand<CR>")
    utils.nmap("<Leader>vs", ":VimuxInterruptRunner<CR>")
    utils.nmap("<Leader>vl", ":VimuxRunLastCommand<CR>")

    --- Rooter
    vim.g.rooter_patterns = {".git"}
  end
)
