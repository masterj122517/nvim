local G = require('G')
local M = {}
return {
    "yaocccc/vim-comment",
    config = function()
        -- vim-comment
        G.g.vim_line_comments = {
            vim = '"',
            vimrc = '"',
            js = '//',
            ts = '//',
            java = '//',
            class = '//',
            c = '//',
            h = '//',
            go = '//',
            lua = '--',
            proto = '//',
            ['go.mod'] = '//',
            md = '[^_^]:',
            vue = '//',
            sql = '--',
            sol = '//',
        }
        G.g.vim_chunk_comments = {
            js = {'/**', ' *', ' */'},
            ts = {'/**', ' *', ' */'},
            sh = {':<<!', '', '!'},
            proto = {'/**', ' *', ' */'},
            md = {'[^_^]:', '    ', ''},
            vue = {'/**', ' *', ' */'},
            sol = {'/**', ' *', ' */'},
        }
        G.map({
            { 'n', '??', ':NToggleComment<cr>', {silent = true, noremap = true}},
            { 'v', '/', ':<c-u>VToggleComment<cr>', {silent = true, noremap = true}},
            { 'v', '?', ':<c-u>CToggleComment<cr>', {silent = true, noremap = true}},
        })
    end
}



