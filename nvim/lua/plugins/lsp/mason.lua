return {
  "williamboman/mason.nvim",
  name = "mason",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    mason.setup({
      ui = {
        icons = {
          package_installed = "",
          package_outdated = "",
          package_not_installed = "",
        }
      }
    })

    mason_lspconfig.setup({
      ensure_installed = {
         "eslint",
         "jsonls",
         "yamlls",
         "dockerls",
         "bashls",
         "vimls",
         "pyright",
      },
      automatic_installation = true,
    })
  end
}
