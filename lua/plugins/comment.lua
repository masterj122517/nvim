return {
    "yaocccc/vim-comment",
    config = function()
        vim.cmd([[
        nmap <silent> ?? :NToggleComment<CR>
        xmap <silent> /  :<c-u>VToggleComment<CR>
        smap <silent> /  <c-g>:<c-u>VToggleComment<CR>
        xmap <silent> ?  :<c-u>CToggleComment<CR>
        smap <silent> ?  <c-g>:<c-u>CToggleComment<CR>
        ]]) 
    end
}



