return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,      -- load before most plugins
    lazy = false,         -- don't lazy-load the theme
    opts = {
      flavour = "mocha",  -- latte, frappe, macchiato, mocha
      transparent_background = false,
      term_colors = true,

      integrations = {
        -- Core
        treesitter = true,
        native_lsp = {
          enabled = true,
          virtual_text = { errors = { "italic" }, hints = { "italic" }, warnings = { "italic" }, information = { "italic" } },
          underlines = { errors = { "underline" }, hints = { "underline" }, warnings = { "underline" }, information = { "underline" } },
          inlay_hints = { background = true },
        },

        -- UI / workflow
        telescope = true,
        which_key = true,
        neo_tree = true,
        gitsigns = true,
        trouble = true,
        notify = true,
        mini = true,
        mason = true,

        -- Completion
        cmp = true,

        -- Optional extras (enable if you use them)
        -- noice = true,
        snacks = true,
        -- dap = { enabled = true, enable_ui = true },
        -- indent_blankline = { enabled = true },
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin-mocha")
    end,
  },

  -- Optional but recommended icons (many plugins assume this)
  { "nvim-tree/nvim-web-devicons", lazy = true },
}
