local split = function()
    vim.cmd("set splitbelow")
    vim.cmd("sp")
    vim.cmd("res -5")
end
local compileRun = function()
    vim.cmd("w")
    local ft = vim.bo.filetype
    if ft == "cpp" then
        split()
        vim.cmd("term g++ % -o %< && ./%< && rm %<")
    elseif ft == "markdown" then
        vim.cmd(":MarkdownPreviewToggle")
    elseif ft == 'c' then
        split()
        vim.cmd("term gcc % -o %< && ./%< && rm %<")
    elseif ft == 'javascript' then
        split()
        vim.cmd("term node %")
    elseif ft == 'lua' then
        split()
        vim.cmd("term luajit %")
    elseif ft == 'tex' then
        vim.cmd(":VimtexCompile")
    elseif ft == 'go' then
        split()
        vim.cmd("term go run %")
    elseif ft == 'python' then
        split()
        vim.cmd("term python %")
    end
end

vim.keymap.set('n', 'com', compileRun, { silent = true })
