return {
    "mg979/vim-visual-multi",
    init = function()
        vim.cmd([[
        let g:VM_maps                       = {}
        let g:VM_maps['Find Under']         = '<C-m>'
        let g:VM_maps['Find Subword Under'] = '<C-m>'
        noremap <leader>sa <Plug>(VM-Select-All)
        ]])
    end
}
