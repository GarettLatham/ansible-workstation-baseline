-- =========================
-- Core settings
-- =========================
vim.g.mapleader = " "
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.updatetime = 200

-- Diagnostics behavior (VSCode-ish)
vim.diagnostic.config({
    virtual_text = false,
    severity_sort = true,
    underline = true,
    update_in_insert = false,
    float = { border = "rounded", source = "always" },
})

-- =========================
-- lazy.nvim bootstrap (MUST be correct)
-- =========================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    })
    end
    vim.opt.rtp:prepend(lazypath)

    -- =========================
    -- Plugins
    -- =========================
    require("lazy").setup({
        --Theme
        {
            "catppuccin/nvim",
            name = "catppuccin",
            priority = 1000, -- load first
            config = function()
            require("catppuccin").setup({
                flavour = "mocha", -- latte, frappe, macchiato, mocha
                transparent_background = false,
                term_colors = true,
                integrations = {
                    treesitter = true,
                    telescope = true,
                    which_key = true,
                    lsp_trouble = true,
                    cmp = true,
                    gitsigns = true,
                    neo_tree = true,
                    bufferline = true,
                    mason = true,
                },
            })

            vim.cmd.colorscheme("catppuccin")
            end,
        },

        -- Icons
        { "nvim-tree/nvim-web-devicons", lazy = true },
        { "echasnovski/mini.icons", version = "*", lazy = true },

        -- Statusline
        {
            "nvim-lualine/lualine.nvim",
            dependencies = { "nvim-tree/nvim-web-devicons" },
            config = function()
            require("lualine").setup({
                options = {
                    icons_enabled = true,
                    theme = "catppuccin",
                    globalstatus = true,
                },
            })
            end,
        },

        -- Git signs
        { "lewis6991/gitsigns.nvim", config = true },

        -- Neo-tree (project tree left)
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim" },
        config = function()
        require("neo-tree").setup({
            default_component_configs = {
                indent = {
                    with_markers = true,
                    indent_size = 2,
                },
                name = {
                    trailing_slash = false,
                    use_git_status_colors = true,
                },
            },
            close_if_last_window = false,
            window = {
                position = "left",
                width = 34,
            },
            filesystem = {
                follow_current_file = { enabled = true },
                use_libuv_file_watcher = true,
                filtered_items = { hide_dotfiles = false, hide_gitignored = false },
            },
        })
        end,
    },

    -- Telescope
    { "nvim-lua/plenary.nvim" },
    { "nvim-telescope/telescope.nvim" },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
        dependencies = { "nvim-telescope/telescope.nvim" },
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        dependencies = { "nvim-telescope/telescope.nvim" },
    },

    -- Treesitter (force early load)
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        priority = 1000,
        build = ":TSUpdate",
        config = function()
        local ok, configs = pcall(require, "nvim-treesitter.configs")
        if not ok then
            vim.schedule(function()
            vim.notify("Treesitter missing: reinstall nvim-treesitter (lazy)", vim.log.levels.WARN)
            end)
            return
            end
            configs.setup({
                highlight = { enable = true },
                indent = { enable = true },
                ensure_installed = {
                    "lua", "vim", "vimdoc", "bash", "python", "yaml", "json", "toml", "markdown", "regex",
                    "go", "rust", "c", "cpp", "java", "javascript", "typescript", "html", "css", "sql",
                    "dockerfile", "terraform", "hcl",
                },
            })
            end,
    },

    -- Trouble (Problems panel)
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        cmd = "Trouble",
        opts = {},
        keys = {
            { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
                          { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
                          { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
                          { "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions / refs" },
                          { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List" },
                          { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List" },
        },
    },

    -- Which-key
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = { preset = "modern" },
    },

    -- Autopairs + surround + comment
    { "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },
    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        config = function()
        require("nvim-surround").setup({})
        end,
    },
    { "numToStr/Comment.nvim", event = "VeryLazy", opts = {} },

    -- Bufferline (tabs at top)
    {
        "akinsho/bufferline.nvim",
        version = "*",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            options = {
                themable = true,
                mode = "buffers",
                diagnostics = "nvim_lsp",
                separator_style = "slant",
                show_close_icon = false,
                show_buffer_close_icons = false,
                always_show_bufferline = true,
                offsets = {
                    { filetype = "neo-tree", text = "Files", text_align = "left", separator = true },
                },
            },
        },
    },

    -- LSP UI polish
    {
        "nvimdev/lspsaga.nvim",
        event = "LspAttach",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {
            ui = { border = "rounded" },
            lightbulb = { enable = true },
        },
    },

    -- LSP / tools
    { "williamboman/mason.nvim", config = true },
    { "williamboman/mason-lspconfig.nvim" },
    { "WhoIsSethDaniel/mason-tool-installer.nvim" },
    { "neovim/nvim-lspconfig" },

    -- Completion
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "L3MON4D3/LuaSnip" },
    { "saadparwaiz1/cmp_luasnip" },

    -- Formatting / lint
    { "stevearc/conform.nvim" },
    { "mfussenegger/nvim-lint" },

    -- Integrated terminal (default horizontal + project root + lazygit)
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        event = "VeryLazy",
        opts = {
            -- Do NOT rely on open_mapping; we bind explicitly below.
            open_mapping = nil,
            direction = "horizontal",
            size = 15,
            start_in_insert = true,
            insert_mappings = true,
            terminal_mappings = true,
            shade_terminals = true,
            float_opts = { border = "rounded" },
        },
        config = function(_, opts)
        require("toggleterm").setup(opts)

        -- Explicit Ctrl+\ mappings so it ALWAYS toggles horizontal split
        vim.keymap.set("n", "<C-\\>", "<cmd>ToggleTerm direction=horizontal<cr>", { desc = "Terminal (horizontal)" })
        vim.keymap.set(
            "t",
            "<C-\\>",
            [[<C-\><C-n><cmd>ToggleTerm direction=horizontal<cr>]],
            { desc = "Terminal (horizontal)" }
        )
        vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

        -- Project root helper (git root if possible, else common project markers, else cwd)
    local function project_root()
    local buf = vim.api.nvim_buf_get_name(0)
    local start = (buf ~= "" and vim.fs.dirname(buf)) or vim.loop.cwd()
    local root = vim.fs.root(start, {
        ".git",
        "pyproject.toml",
        "package.json",
        "go.mod",
        "Cargo.toml",
        ".terraform",
        ".hg",
    })
    return root or vim.loop.cwd()
    end

    local Terminal = require("toggleterm.terminal").Terminal

    -- Root terminal: horizontal split, cd to project root on open
    local root_term = Terminal:new({
        cmd = vim.o.shell,
        direction = "horizontal",
        close_on_exit = false,
        hidden = true,
        on_open = function(term)
        local root = project_root()
        pcall(vim.api.nvim_chan_send, term.job_id, "cd " .. vim.fn.fnameescape(root) .. "\n")
        end,
    })

    -- LazyGit: float by default (nice UI), cd to project root on open
    local lazygit_term = Terminal:new({
        cmd = "lazygit",
        direction = "float",
        hidden = true,
        close_on_exit = true,
        float_opts = { border = "rounded" },
        on_open = function(term)
        local root = project_root()
        pcall(vim.api.nvim_chan_send, term.job_id, "cd " .. vim.fn.fnameescape(root) .. "\n")
        end,
    })

    vim.keymap.set("n", "<leader>tr", function()
    root_term:toggle()
    end, { desc = "Terminal (project root)" })

    vim.keymap.set("n", "<leader>tg", function()
    lazygit_term:toggle()
    end, { desc = "LazyGit" })
    end,
    },
    }, {
        defaults = { lazy = false },
    })

    -- =========================
    -- Keymaps
    -- =========================
    local map = vim.keymap.set

    -- Neo-tree
    map("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Explorer" })
    map("n", "<leader>o", "<cmd>Neotree focus<cr>", { desc = "Focus tree" })

    -- Telescope
    map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
    map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })
    map("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Recent files" })
    map("n", "<leader>fc", "<cmd>Telescope git_commits<cr>", { desc = "Git commits" })
    map("n", "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", { desc = "Symbols (document)" })
    map("n", "<leader>fS", "<cmd>Telescope lsp_workspace_symbols<cr>", { desc = "Symbols (workspace)" })
    map("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>", { desc = "Find diagnostics" })

    -- Bufferline
    map("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
    map("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
    map("n", "<leader>bp", "<cmd>BufferLinePick<cr>", { desc = "Pick buffer" })
    map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Close buffer" })

    -- Lspsaga (VSCode-ish)
    map("n", "K", "<cmd>Lspsaga hover_doc<cr>", { desc = "Hover docs" })
    map("n", "<C-k>", "<cmd>Lspsaga signature_help<cr>", { desc = "Signature help" })
    map({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<cr>", { desc = "Code action" })
    map("n", "<leader>cr", "<cmd>Lspsaga rename<cr>", { desc = "Rename symbol" })
    map("n", "gd", "<cmd>Lspsaga goto_definition<cr>", { desc = "Go to definition" })
    map("n", "gD", "<cmd>Lspsaga peek_definition<cr>", { desc = "Peek definition" })
    map("n", "gr", "<cmd>Lspsaga finder<cr>", { desc = "References / definitions" })
    map("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<cr>", { desc = "Prev diagnostic" })
    map("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<cr>", { desc = "Next diagnostic" })
    map("n", "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<cr>", { desc = "Line diagnostics" })
    map("n", "<leader>cD", "<cmd>Lspsaga show_cursor_diagnostics<cr>", { desc = "Cursor diagnostics" })

    -- =========================
    -- Completion (cmp)
    -- =========================
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    cmp.setup({
        snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
              mapping = cmp.mapping.preset.insert({
                  ["<C-Space>"] = cmp.mapping.complete(),
                                                  ["<CR>"] = cmp.mapping.confirm({ select = true }),
              }),
              sources = {
                  { name = "nvim_lsp" },
                  { name = "luasnip" },
                  { name = "path" },
                  { name = "buffer" },
              },
    })

    -- =========================
    -- LSP (Neovim 0.11+ API)
    -- =========================
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    require("mason-lspconfig").setup({
        ensure_installed = {
            "bashls",
            "pyright",
            "yamlls",
            "jsonls",
            "lua_ls",
            "gopls",
            "rust_analyzer",
            "clangd",
            "jdtls",
            "ts_ls",
            "html",
            "cssls",
            "dockerls",
            "terraformls",
        },
    })

    require("mason-tool-installer").setup({
        ensure_installed = {
            "stylua",
            "shfmt",
            "prettier",
            "black",
            "ruff",
            "ansible-lint",
            "yamllint",
            "eslint_d",
            "shellcheck",
        },
        run_on_start = true,
    })

    vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        settings = { Lua = { diagnostics = { globals = { "vim" } } } },
    })
    vim.lsp.config("bashls", { capabilities = capabilities })
    vim.lsp.config("pyright", { capabilities = capabilities })

    vim.lsp.enable({
        "lua_ls",
        "bashls",
        "pyright",
        "yamlls",
        "jsonls",
        "gopls",
        "rust_analyzer",
        "clangd",
        "jdtls",
        "ts_ls",
        "html",
        "cssls",
        "dockerls",
        "terraformls",
    })

    -- =========================
    -- Formatting (conform)
    -- =========================
    require("conform").setup({
        format_on_save = { timeout_ms = 1500, lsp_fallback = true },
    })

    -- =========================
    -- Linting (nvim-lint)
    -- =========================
    local lint = require("lint")
    lint.linters_by_ft = {
        yaml = { "yamllint", "ansible_lint" },
        sh = { "shellcheck" },
        bash = { "shellcheck" },
        python = { "ruff" },
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
    }

    vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
        callback = function()
        lint.try_lint()
        end,
    })

    -- =========================
    -- Telescope setup (extensions)
    -- =========================
    local telescope = require("telescope")
    telescope.setup({
        extensions = {
            ["ui-select"] = require("telescope.themes").get_dropdown({}),
        },
    })
    pcall(telescope.load_extension, "fzf")
    pcall(telescope.load_extension, "ui-select")

    -- =========================
    -- which-key groups
    -- =========================
    local wk = require("which-key")
    wk.add({
        { "<leader>c", group = "Code" },
        { "<leader>f", group = "Find" },
        { "<leader>t", group = "Terminal" },
        { "<leader>x", group = "Diagnostics" },
    })

    vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
        require("neo-tree.command").execute({ action = "show", source = "filesystem", position = "left" })
        end,
    })
    -- Auto-open a horizontal terminal on startup
    vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
        -- small delay so UI + plugins finish loading cleanly
        vim.defer_fn(function()
        pcall(vim.cmd, "ToggleTerm direction=horizontal")
        end, 50)
        end,
    })
    vim.api.nvim_create_autocmd("TermOpen", {
        pattern = "term://*toggleterm#*",
        callback = function()
        vim.cmd("startinsert")
        end,
    })


