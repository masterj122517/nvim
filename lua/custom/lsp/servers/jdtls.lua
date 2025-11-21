local M = {}

function M.setup()
  local home = os.getenv 'HOME'
  local workspace_dir = home .. '/.local/share/jdtls-workspace/' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t') -- 每个项目独立 workspace

  vim.lsp.config('jdtls', {
    cmd = {
      'java',
      '-Declipse.application=org.eclipse.jdt.ls.core.id1',
      '-Dosgi.bundles.defaultStartLevel=4',
      '-Declipse.product=org.eclipse.jdt.ls.core.product',
      '-jar',
      vim.fn.expand '~/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar',
      '-configuration',
      vim.fn.expand '~/.local/share/nvim/mason/packages/jdtls/config_mac',
      '-data',
      workspace_dir,
    },

    -- 用来识别项目根的标记
    root_markers = {
      'pom.xml',
      'build.gradle',
      'mvnw',
      'gradlew',
      '.git',
    },

    -- 基础设置即可
    settings = {
      java = {},
    },

    -- 启动时绑定你的 on_attach & capabilities
    on_attach = require('custom.lsp').on_attach,
    capabilities = require('custom.lsp').capabilities,
  })

  vim.lsp.enable 'jdtls'
end

return M
