local split = function()
  vim.cmd("set splitbelow")
  vim.cmd("sp")
  vim.cmd("res -5")
end

local compileRun = function()
  local function find_project_root(path)
    if vim.fn.filereadable(path .. "/Makefile") == 1 then
      return path
    end
    local parent = vim.fn.fnamemodify(path, ":h")
    if parent == path then
      return nil
    else
      return find_project_root(parent)
    end
  end

  local function find_first_executable(path)
    local handle = io.popen("find " .. path .. " -type d -name '.*' -prune -o -type f -executable -print -quit")
    local executable = handle:read("*line")
    handle:close()
    return executable
  end

  vim.cmd("w")
  local ft = vim.bo.filetype
  local current_file_dir = vim.fn.expand("%:p:h")
  local project_root = find_project_root(current_file_dir)
  if ft == "cpp" or ft == "c" then
    if project_root then
      split()
      vim.cmd("term cd " .. project_root .. " && make && exit")
      vim.cmd("sleep 500m")
      vim.cmd("bd!")
      local executable = find_first_executable(project_root)
      if executable then
        split()
        vim.cmd("term " .. executable .. " && make -s clean  && exit")
      end
    else
      split()
      if ft == "cpp" then
        vim.cmd("term g++ % -o %< && ./%< && rm %<")
      else
        vim.cmd("term gcc % -o %< && ./%< && rm %<")
      end
    end
  elseif ft == "markdown" then
    vim.cmd(":MarkdownPreviewToggle")
  elseif ft == "javascript" then
    split()
    vim.cmd("term node %")
  elseif ft == "lua" then
    split()
    vim.cmd("term luajit %")
  elseif ft == "tex" then
    vim.cmd(":VimtexCompile")
  elseif ft == "go" then
    split()
    vim.cmd("term go run %")
  elseif ft == "python" then
    split()
    vim.cmd("term python %")
  end
end

vim.keymap.set("n", "com", compileRun, { silent = true })
