return {
  -- Oxocarbon theme
  {
    "nyoom-engineering/oxocarbon.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme "oxocarbon"
    end,
  },

  -- File explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = "nvim-tree/nvim-web-devicons",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    keys = {
      { "<C-n>", "<cmd>NvimTreeToggle<CR>", desc = "Toggle nvim-tree" },
      { "<leader>e", "<cmd>NvimTreeFocus<CR>", desc = "Focus nvim-tree" },
    },
    opts = {
      filters = { dotfiles = false },
      disable_netrw = true,
      hijack_cursor = true,
      sync_root_with_cwd = true,
      update_focused_file = {
        enable = true,
        update_root = false,
      },
      view = {
        width = 30,
        preserve_window_proportions = true,
      },
      renderer = {
        root_folder_label = false,
        highlight_git = true,
        indent_markers = { enable = true },
        icons = {
          glyphs = {
            default = "󰈚",
            folder = {
              default = "",
              empty = "",
              empty_open = "",
              open = "",
              symlink = "",
            },
            git = { unmerged = "" },
          },
        },
      },
    },
    config = function(_, opts)
      require("nvim-tree").setup(opts)
    end,
  },

  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      theme = "oxocarbon",
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
    },
  },

  -- Buffer management
  {
    "akinsho/bufferline.nvim",
    event = "BufReadPre",
    keys = {
      { "<Tab>", "<cmd>BufferLineCycleNext<CR>", desc = "Next buffer", mode = "n" },
      { "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", desc = "Previous buffer", mode = "n" },
      { "<leader>x", "<cmd>bdelete<CR>", desc = "Close buffer" },
    },
    opts = {
      options = {
        themable = true,
        close_command = "bdelete! %d",
        right_mouse_command = "bdelete! %d",
        offsets = {
          { filetype = "NvimTree", text = "Explorer", text_align = "center" },
        },
      },
    },
    config = function(_, opts)
      require("bufferline").setup(opts)
    end,
  },

  -- Which-key
  {
    "folke/which-key.nvim",
    keys = { "<leader>", "<c-r>", "<c-w>", '"', "'", "`", "c", "v", "g" },
    cmd = "WhichKey",
    opts = {},
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>fw", "<cmd>Telescope live_grep<CR>", desc = "Live grep" },
      { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Find buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Help page" },
      { "<leader>fo", "<cmd>Telescope oldfiles<CR>", desc = "Find oldfiles" },
      { "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", desc = "Find in current buffer" },
      { "<leader>fa", "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>", desc = "Find all" },
      { "<leader>cm", "<cmd>Telescope git_commits<CR>", desc = "Git commits" },
      { "<leader>gt", "<cmd>Telescope git_status<CR>", desc = "Git status" },
      { "<leader>ma", "<cmd>Telescope marks<CR>", desc = "Telescope bookmarks" },
    },
    opts = function()
      return {
        defaults = {
          prompt_prefix = "   ",
          selection_caret = " ",
          entry_prefix = " ",
          sorting_strategy = "ascending",
          layout_config = {
            horizontal = {
              prompt_position = "top",
              preview_width = 0.55,
            },
            width = 0.87,
            height = 0.80,
          },
          mappings = {
            n = { ["q"] = require("telescope.actions").close },
          },
        },
      }
    end,
    config = function(_, opts)
      require("telescope").setup(opts)
    end,
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    event = "User FilePost",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- Mason
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
    opts = {
      ensure_installed = {
        "lua-language-server", "stylua",
        "html-lsp", "css-lsp", "prettier",
        "pyright", "clangd", "bash-language-server",
        "typescript-language-server"
      },
    },
  },

  -- Mason LSP Config bridge
  {
    "williamboman/mason-lspconfig.nvim",
    event = "User FilePost",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = { "lua_ls", "pyright", "html", "cssls", "clangd", "bashls", "tsserver" },
      automatic_installation = true,
    },
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "vim", "lua", "vimdoc",
        "html", "css"
      },
      highlight = { enable = true },
      indent = { enable = true },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  -- Formatting
  {
    "stevearc/conform.nvim",
    event = 'BufWritePre',
    config = function()
      require "configs.conform"
    end,
  },

  -- Completion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      {
        "L3MON4D3/LuaSnip",
        dependencies = "rafamadriz/friendly-snippets",
        opts = { history = true, updateevents = "TextChanged,TextChangedI" },
        config = function(_, opts)
          require("luasnip").config.set_config(opts)
          require("luasnip.loaders.from_vscode").lazy_load()
        end,
      },
    },
    opts = function()
      return {
        completion = { completeopt = "menu,menuone" },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = {
          ["<C-p>"] = require("cmp").mapping.select_prev_item(),
          ["<C-n>"] = require("cmp").mapping.select_next_item(),
          ["<C-d>"] = require("cmp").mapping.scroll_docs(-4),
          ["<C-f>"] = require("cmp").mapping.scroll_docs(4),
          ["<C-Space>"] = require("cmp").mapping.complete(),
          ["<C-e>"] = require("cmp").mapping.close(),
          ["<CR>"] = require("cmp").mapping.confirm {
            behavior = require("cmp").ConfirmBehavior.Insert,
            select = true,
          },
          ["<Tab>"] = require("cmp").mapping(function(fallback)
            if require("cmp").visible() then
              require("cmp").select_next_item()
            elseif require("luasnip").expand_or_jumpable() then
              require("luasnip").expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = require("cmp").mapping(function(fallback)
            if require("cmp").visible() then
              require("cmp").select_prev_item()
            elseif require("luasnip").jumpable(-1) then
              require("luasnip").jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        },
      }
    end,
  },
}
