return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    local toggleterm = require("toggleterm")

    toggleterm.setup({
      size = 10,
      open_mapping = [[<c-\>]],
      insert_mapping = true,
      hide_numbers = true,
      direction = "horizontal",
    })

    -- keymaps
    local map = vim.api.nvim_set_keymap
    local opts = { noremap = true, silent = true }

    map("t", "<esc>", [[<C-\><C-n>]], opts)
    map("t", "jk", [[<C-\><C-n>]], opts)
    map("t", "<C-h>", [[<C-\><C-n><C-w>h]], opts)
    map("t", "<C-j>", [[<C-\><C-n><C-w>j]], opts)
    map("t", "<C-k>", [[<C-\><C-n><C-w>k]], opts)
    map("t", "<C-l>", [[<C-\><C-n><C-w>l]], opts)
    map("n", "<C-h>", [[<C-\><C-n><C-w>h]], opts)
    map("n", "<C-j>", [[<C-\><C-n><C-w>j]], opts)
    map("n", "<C-k>", [[<C-\><C-n><C-w>k]], opts)
    map("n", "<C-l>", [[<C-\><C-n><C-w>l]], opts)
  end,
}
