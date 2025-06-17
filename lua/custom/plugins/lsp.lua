return
{
        {
            "neovim/nvim-lspconfig",
            config = fuction()
                require'lspconfig'.intelephense.setup{}
            end,
        }
}
