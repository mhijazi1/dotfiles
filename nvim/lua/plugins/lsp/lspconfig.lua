return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "williamboman/mason-lspconfig.nvim",
  },

  --- v2-style: declare servers & per-server settings in opts
  opts = {
    servers = {
      -- generic servers (empty tables pick defaults)
      eslint = {},
      jsonls = {},
      yamlls = {},
      dockerls = {},
      bashls = {},
      vimls = {},
      pyright = {},

      -- special config for lua
      lua_ls = {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            completion = { callSnippet = "Replace" },
          },
        },
      },
    },
  },

  config = function(_, opts)
    local lspconfig = require("lspconfig")
    local mason_lspconfig = require("mason-lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    -- Create buffer-local keymaps on attach (same behavior as before)
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local keymap = vim.keymap
        local opts0 = { buffer = ev.buf, silent = true }

        opts0.desc = "Show LSP references"
        keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts0)

        opts0.desc = "Go to declaration"
        keymap.set("n", "gD", vim.lsp.buf.declaration, opts0)

        opts0.desc = "Show LSP definitions"
        keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts0)

        opts0.desc = "Show LSP implementations"
        keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts0)

        opts0.desc = "Show LSP type definitions"
        keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts0)

        opts0.desc = "See available code actions"
        keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts0)

        opts0.desc = "Smart rename"
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts0)

        opts0.desc = "Show buffer diagnostics"
        keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts0)

        opts0.desc = "Show line diagnostics"
        keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts0)

        opts0.desc = "Go to previous diagnostic"
        keymap.set("n", "[d", vim.diagnostic.goto_prev, opts0)

        opts0.desc = "Go to next diagnostic"
        keymap.set("n", "]d", vim.diagnostic.goto_next, opts0)

        opts0.desc = "Show documentation for cursor"
        keymap.set("n", "K", vim.lsp.buf.hover, opts0)

        opts0.desc = "Restart LSP"
        keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts0)
      end,
    })

    -- Diagnostic signs (unchanged)
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    -- Shared capabilities (completion)
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- v2-style: use mason-lspconfig handlers that read per-server opts
    local servers = opts.servers or {}
  end,
}

