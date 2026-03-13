-- init.lua or plugins.lua
return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",       -- required
      "nvim-tree/nvim-web-devicons", -- optional but recommended
      "MunifTanjim/nui.nvim",        -- REQUIRED for Neo-tree
    },
    keys = {
      { "<leader>e", ":Neotree toggle<CR>", desc = "Toggle Neo-tree" },
      { "<leader>r", ":Neotree reveal<CR>", desc = "Reveal current file" },
    },
    config = function()
      require("neo-tree").setup({
        close_if_last_window = true,
        filesystem = { follow_current_file = true },
        window = { width = 35, mappings = {} },
      })
    end,
  },
}
