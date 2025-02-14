return {
  {
    "hrsh7th/nvim-cmp",
    name = "nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer", -- source for text in the current buffer
      "hrsh7th/cmp-nvim-lsp", -- source for LSP completions
      "hrsh7th/cmp-nvim-lsp-signature-help", -- source for LSP completions
      "hrsh7th/cmp-path", -- source for file paths
      "L3MON4D3/LuaSnip", -- snippet engine
      "rafamadriz/friendly-snippets", -- collection of snippets
      "saadparwaiz1/cmp_luasnip", -- source for LuaSnip snippets
    },
    config = function()
      local cmp = require("cmp")
      local lua_snip = require("luasnip")

      -- loads vscode style snippets
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        completion = {
          completeopt = "menu,menuone,preview,noselect",
        },
        snippet = {
          expand = function(args)
            lua_snip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-k>'] = cmp.mapping.select_prev_item(),
          ['<C-j>'] = cmp.mapping.select_next_item(),
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = false }),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "nvim_lsp_signature_help" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
          { name = "orgmode" },
        },
      })
    end,
  },
}
