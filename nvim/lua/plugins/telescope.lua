return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
          }
        }
      }
    })

    -- keymaps
    local keymap = vim.keymap

    keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "fuzzy find files"})
    keymap.set("n", "<C-p>",      "<cmd>Telescope find_files<cr>", { desc = "fuzzy find files"})
    keymap.set("n", "<leader>fr", "<cmd>Telescope oldfile<cr>", { desc = "fuzzy find recent files"})
    keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "find string"})
    keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "find string under cursor"})
    keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "find buffers"})

    -- Lazy related


    -- git related
    keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>", { desc = "git status" })
    keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", { desc = "git commits" })
    keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", { desc = "git branches" })
  end
}
