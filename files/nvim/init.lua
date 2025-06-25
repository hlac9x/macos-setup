vim.opt.number = true                  -- show line number
vim.opt.relativenumber = true          -- show line number
vim.g.mapleader = " "                  -- map LEADER to space
vim.keymap.set("n", "<C-s>", ":w<CR>") -- save File
vim.keymap.set("n", "<C-q>", ":q<CR>") -- quit File
vim.keymap.set("v", "<C-c>", '"+y')    -- copy text to the clipboard
vim.keymap.set("v", "<C-v>", '"+p')    -- past text to the clipboard
vim.g.maplocalleader = ','             -- confirm replace work
vim.opt.ignorecase = true              -- ignore case in search patterns
vim.opt.smartcase = true               -- smart case
vim.opt.smartindent = true             -- make indenting smarter again
vim.opt.splitbelow = true              -- force all horizontal splits to go below current window
vim.opt.splitright = true              -- force all vertical splits to go to the right of current window
vim.opt.swapfile = false               -- creates a swapfile
vim.opt.undofile = true                -- enable persistent undo
vim.opt.expandtab = true               -- convert tabs to spaces
vim.opt.shiftwidth = 4                 -- the number of spaces inserted for each indentation
vim.opt.tabstop = 4                    -- insert 2 spaces for a tab
vim.opt.cursorline = true              -- highlight the current line
vim.opt.signcolumn = "yes"             -- always show the sign column, otherwise it would shift the text each time
vim.opt.scrolloff = 3                  -- minimal number of screen lines to keep above and below the cursor

--  {{{ Plugin Manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git", "--branch=stable", -- latest stable release
        lazypath
    })
end
-- }}}

vim.opt.rtp:prepend(lazypath)
return require("lazy").setup({                                         -- {{{ Libraries
    { "https://github.com/nvim-lua/plenary.nvim",       lazy = true }, -- }}}
    -- {{{ Themes
    --     "https://github.com/ellisonleao/gruvbox.nvim",
    --     event = "VeryLazy",
    --     config = function()
    --         vim.cmd("colorscheme gruvbox")
    --     end
    -- },
    {
        "https://github.com/Tsuzat/NeoSolarized.nvim",
        event = "VeryLazy",
        config = function()
            vim.cmd("colorscheme NeoSolarized")
            style = "dark"
        end
    },                                                                 -- }}}
    -- {{{ Utilities
    { "https://github.com/nvim-tree/nvim-web-devicons", lazy = true }, -- {
    { "https://github.com/farmergreg/vim-lastplace",    event = "BufReadPost" }, {
    "https://github.com/tpope/vim-sleuth",
    event = "VeryLazy",
    config = function() vim.cmd("silent Sleuth") end
}, {
    "https://github.com/numToStr/Comment.nvim",
    event = "VeryLazy",
    config = function() require("Comment").setup() end
}, {
    "https://github.com/windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function() require("nvim-autopairs").setup() end
}, {
    "https://github.com/echasnovski/mini.surround",
    event = "VeryLazy",
    config = function()
        require("mini.surround").setup({
            mappings = {
                add = "sa",
                delete = "sd",
                find = "sf",
                find_left = "sF",
                highlight = "sh",
                replace = "sr",
                update_n_lines = "sn"
            }
        })
    end
}, {
    "https://github.com/MagicDuck/grug-far.nvim",
    lazy = true,
    config = function() require("grug-far").setup({}) end,
    keys = {
        {
            "<LEADER>sr", function()
            require("grug-far").grug_far({
                prefills = { flags = vim.fn.expand("%") }
            })
        end, "Search and replace in current file"
        }, {
        "<LEADER>sR", function()
        require("grug-far").grug_far({})
    end, "Search and replace in project"
    }
    }
}, -- }}}
    -- {{{ Git
    {
        "https://github.com/lewis6991/gitsigns.nvim",
        event = "VeryLazy",
        config = function()
            require("gitsigns").setup({ current_line_blame = true })
        end
    }, { "https://github.com/tpope/vim-fugitive", cmd = "Git" }, {
    "https://github.com/echasnovski/mini.diff",
    event = "VeryLazy",
    config = function() require("mini.diff").setup({}) end
}, -- }
    -- {{{ Search
    -- {
    --     "https://github.com/ibhagwan/fzf-lua",
    --     event = "VeryLazy",
    --     dependencies = { "nvim-tree/nvim-web-devicons" },
    --     config = function()
    --         require("fzf-lua").setup({
    --             "max-perf",
    --             winopts     = {
    --                 height = 0.5,
    --                 width = 1,
    --                 row = 1,
    --             },
    --             files = {
    --                 prompt = 'Files❯ ',
    --                 previewer = true,      -- enable file previews
    --                 git_icons = true,      -- show git icons
    --                 file_icons = "devicons",     -- show file icons
    --                 color_icons = true,    -- enable color for icons
    --             },
    --             grep = {
    --                 prompt = 'Grep❯ ',
    --                 git_icons = true,      -- show git icons
    --                 file_icons = true,     -- show file icons
    --                 color_icons = true,    -- enable color for icons
    --             },
    --             lsp = {
    --             prompt = 'LSP❯ ',
    --             icons = {
    --                 ["Error"] = "✘",
    --                 ["Warning"] = "▲",
    --                 ["Information"] = "ℹ",
    --                 ["Hint"] = "⚑",
    --             },
    --             },
    --         })
    --         require("fzf-lua").register_ui_select()
    --     end,
    --     keys = {
    --         { "<LEADER><LEADER>", ":FzfLua files<CR>" },
    --         { "<LEADER>/",        ":FzfLua grep_project<CR>" },
    --         { "<LEADER>?",        ":FzfLua live_grep<CR>" },
    --         { "<LEADER>fg",       ":FzfLua git_files<CR>" },
    --     }
    -- },
    {
        "https://github.com/nvim-telescope/telescope.nvim",
        event = "VeryLazy",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
            "nvim-tree/nvim-web-devicons",
            "nvim-telescope/telescope-file-browser.nvim"
        },
        config = function()
            local telescope = require("telescope")
            local actions = require("telescope.actions")
            telescope.setup({
                defaults = {
                    path_display = { "smart" }
                    -- mappings = {
                    --     i = {
                    --         ["<C-k>"] = actions.move_selection_previous, -- move to prev result
                    --         ["<C-j>"] = actions.move_selection_next, -- move to next result
                    --         ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist
                    --     }
                    -- }
                }
                -- pickers = {
                --     find_files = {
                --         theme = "ivy"
                --     }
                -- }
            })

            telescope.load_extension("fzf")
        end,
        keys = {
            {
                "<LEADER><LEADER>",
                function()
                    local builtin = require("telescope.builtin")
                    local utils = require("telescope.utils")
                    builtin.find_files({ cwd = utils.buffer_dir() })
                end,
                desc = "Find files in current folder"
            }, {
            "<LEADER>ff", function()
            local builtin = require("telescope.builtin")
            builtin.find_files({ no_ignore = false, hidden = true })
        end
        }, {
            "<LEADER>?", function()
            local builtin = require("telescope.builtin")
            builtin.live_grep()
        end
        }
        }
    }, -- }}}
    -- {{{ IntelliSense
    {
        "https://github.com/VonHeikemen/lsp-zero.nvim",
        dependencies = {
            "https://github.com/neovim/nvim-lspconfig",
            "https://github.com/hrsh7th/nvim-cmp",
            "https://github.com/hrsh7th/cmp-nvim-lsp",
            "https://github.com/hrsh7th/cmp-path",
            "https://github.com/hrsh7th/cmp-buffer",
            "https://github.com/L3MON4D3/LuaSnip"
        },
        event = "VeryLazy",
        config = function()
            local lsp_zero = require("lsp-zero")
            local cmp = require("cmp")
            local cmp_action = lsp_zero.cmp_action()

            lsp_zero.setup_servers(
                { -- Requires language servers to be already installed
                    -- :help lspconfig-all
                    "gopls", "lua_ls", "pyright", "rust_analyzer",
                    "terraformls", "ts_ls"
                })

            -- HACK manually start LSP server after lazy load
            vim.cmd("filetype detect")

            cmp.setup({
                sources = {
                    { name = "nvim_lsp" }, { name = "path" }, { name = "buffer" }
                },
                mapping = cmp.mapping.preset.insert({
                    ["<CR>"] = cmp.mapping.confirm(),
                    ["<Tab>"] = cmp_action.luasnip_supertab(),
                    ["<S-Tab>"] = cmp_action.luasnip_shift_supertab()
                })
            })

            lsp_zero.on_attach(function(client, bufnr)
                local opts = { buffer = bufnr }
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts)
                vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)
                vim.keymap.set("n", "gR", vim.lsp.buf.rename, opts)
                vim.keymap
                    .set({ "n", "x" }, "<Leader>=", vim.lsp.buf.format, opts)
                vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, opts)
                vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
                vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
                vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
                vim.api.nvim_create_autocmd("BufWritePre", {
                    callback = function()
                        vim.lsp.buf.format()
                    end
                })
            end)
        end
    }, {
    "https://github.com/lukas-reineke/indent-blankline.nvim",
    event = "VeryLazy",
    config = function()
        require("ibl").setup({
            indent = { char = "▏", tab_char = "→" },
            scope = { enabled = false }
        })
    end
}, {
    "https://github.com/nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "VeryLazy",
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "go", "hcl", "lua", "nix", "puppet", "python", "rust",
                "terraform", "tsx", "typescript", "vimdoc"
            },
            highlight = { enable = true },
            indent = { enable = true }
        })
    end
}, -- {{{ File manager
    {
        "https://github.com/stevearc/oil.nvim",
        cmd = "Oil",
        config = function()
            local oil = require("oil")
            oil.setup({
                columns = {},
                view_options = {
                    show_hidden = true,
                    is_always_hidden = function(name, bufnr)
                        return name == ".."
                    end
                },
                win_options = { concealcursor = "nvic" }
            })
        end,
        keys = { { "-", ":Oil<CR>" } }
    }
})
