return {
  "nvim-tree/nvim-tree.lua",
  name = "nvim-tree",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },

  config = function()
    require("nvim-tree").setup {}
  end,
  keys = {
    { "<leader>nt", "<cmd>NvimTreeToggle<cr>", "Toggle NvimTree" },
    { "<C-b>", "<cmd>NvimTreeFindFileToggle<cr>", "Toggle NvimTree" },
    { "<leader>T", "<cmd>NvimTreeFocus<cr>", "Toggle NvimTree" },
  },
}
