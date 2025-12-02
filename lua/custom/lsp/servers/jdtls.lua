local M = {}

function M.setup()
  local home = os.getenv 'HOME'
  local workspace_dir = home .. '/.local/share/jdtls-workspace/' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')

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

    root_markers = {
      'pom.xml',
      'build.gradle',
      'mvnw',
      'gradlew',
      '.git',
    },

    settings = {
      java = {
        format = {
          enabled = true,
          settings = {
            -- google-java-format XML 文件路径
            url = vim.fn.expand '~/.local/share/nvim/mason/packages/google-java-format/google-java-format_darwin-arm64',
            profile = 'GoogleStyle',
          },
        },
      },
    },

    on_attach = require('custom.lsp').on_attach,
    capabilities = require('custom.lsp').capabilities,
  })

  vim.lsp.enable 'jdtls'
end

return M
