return {
    "mg979/vim-visual-multi",
    init = function()
        vim.cmd([[
        let g:VM_maps                       = {}
        let g:VM_maps['Find Under']         = '<C-k>'
        let g:VM_maps['Find Subword Under'] = '<C-k>'
        noremap <leader>sa <Plug>(VM-Select-All)
        ]])
    end
}
