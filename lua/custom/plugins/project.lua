local function load_project_config()
  local path = vim.fs.joinpath(vim.fn.getcwd(), '.vim.lua')
  if vim.fn.filereadable(path) ~= 1 then
    return
  end

  local contents = vim.secure.read(path)
  if type(contents) ~= 'string' then
    return
  end

  local chunk, load_error = load(contents, '@' .. path, 't', _G)
  if not chunk then
    vim.notify(('Failed to load %s: %s'):format(path, load_error), vim.log.levels.ERROR)
    return
  end

  local ok, runtime_error = pcall(chunk)
  if not ok then
    vim.notify(('Failed to execute %s: %s'):format(path, runtime_error), vim.log.levels.ERROR)
  end
end

return {
  'airblade/vim-rooter',
  init = function()
    vim.g.rooter_patterns = {
      '__vim_project_root',
      'pnpm-workspace.yaml',
      'pnpm-lock.yaml',
      'bun.lock',
      'bun.lockb',
      'yarn.lock',
      'package-lock.json',
      'deno.json',
      'deno.jsonc',
      'angular.json',
      'pom.xml',
      'build.gradle',
      'settings.gradle',
      '.git/',
      'package.json',
      'src/',
    }
    vim.g.rooter_silent_chdir = true
    vim.g.rooter_cd_cmd = 'lcd'

    vim.api.nvim_create_autocmd('User', {
      pattern = 'RooterChDir',
      group = vim.api.nvim_create_augroup('masterjVim_project_config', { clear = true }),
      callback = load_project_config,
    })
  end,
}
