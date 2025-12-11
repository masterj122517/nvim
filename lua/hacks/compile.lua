local split = function()
  vim.cmd 'set splitbelow'
  vim.cmd 'sp'
  vim.cmd 'res -5'
end

local compileRun = function()
  local function find_project_root(path)
    if vim.fn.filereadable(path .. '/Makefile') == 1 then
      return path
    end
    local parent = vim.fn.fnamemodify(path, ':h')
    if parent == path then
      return nil
    else
      return find_project_root(parent)
    end
  end

  local function find_first_executable(path)
    local handle = io.popen('find ' .. path .. " -type d -name '.*' -prune -o -type f -executable -print -quit")
    local executable = handle:read '*line'
    handle:close()
    return executable
  end

  vim.cmd 'w'
  local ft = vim.bo.filetype
  local current_file_dir = vim.fn.expand '%:p:h'
  local project_root = find_project_root(current_file_dir)

  if ft == 'cpp' or ft == 'c' then
    local dap_status, dap = pcall(require, 'dap')
    local dapui_status, dapui = pcall(require, 'dapui')
    if dap_status then
      -- dap 可用，使用 dap 调试
      if project_root then
        vim.cmd('!make -C ' .. project_root) -- 构建项目
        local executable = find_first_executable(project_root)
        if executable then
          if dapui_status then
            dapui.open()
          end
          dap.run {
            type = 'codelldb', -- 你的 adapter 名称
            request = 'launch',
            name = 'Debug Project',
            program = executable,
            cwd = project_root,
            stopOnEntry = false,
            runInTerminal = true,
          }
          return
        end
      else
        -- 单文件
        local exe = vim.fn.expand '%:p:r'
        vim.fn.system('g++ -g ' .. vim.fn.expand '%' .. ' -o ' .. exe)
        if dapui_status then
          dapui.open()
        end
        dap.run {
          type = 'codelldb',
          request = 'launch',
          name = 'Debug File',
          program = exe,
          cwd = vim.fn.getcwd(),
          stopOnEntry = false,
          runInTerminal = true,
        }
        return
      end
    end

    -- 如果 dap 不可用，保持原逻辑
    if project_root then
      split()
      vim.cmd('term cd ' .. project_root .. ' && make && exit')
      vim.cmd 'sleep 500m'
      vim.cmd 'bd!'
      local executable = find_first_executable(project_root)
      if executable then
        split()
        vim.cmd('term ' .. executable .. ' && make -s clean && exit')
      end
    else
      split()
      if ft == 'cpp' then
        vim.cmd 'term g++ % -o %< && ./%< && rm %<'
      else
        vim.cmd 'term gcc % -o %< && ./%< && rm %<'
      end
    end
  elseif ft == 'markdown' then
    vim.cmd ':MarkdownPreviewToggle'
  elseif ft == 'typst' then
    vim.cmd ':TypstPreview'
  elseif ft == 'javascript' then
    split()
    vim.cmd 'term node %'
  elseif ft == 'lua' then
    split()
    vim.cmd 'term luajit %'
  elseif ft == 'tex' then
    vim.cmd ':VimtexCompile'
  elseif ft == 'go' then
    split()
    vim.cmd 'term go run %'
  elseif ft == 'python' then
    split()
    vim.cmd 'term python3 %'
  elseif ft == 'rust' then
    split()
    vim.cmd 'term cargo run %'
  elseif ft == 'cs' then
    split()
    vim.cmd 'term dotnet run %'
  elseif ft == 'java' then
    split()
    vim.cmd 'term make run'
  elseif ft == 'haskell' then
    vim.cmd('Compile ghc ' .. vim.fn.expand '%:t')
  end
end

vim.keymap.set('n', 'com', compileRun, { silent = true })
