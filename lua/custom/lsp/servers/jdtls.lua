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
      '-Dlog.protocol=true',
      '-Dlog.level=ALL',
      '--add-modules=ALL-SYSTEM',
      '--add-opens',
      'java.base/java.lang=ALL-UNNAMED',
      '--add-opens',
      'java.base/java.util=ALL-UNNAMED',

      '-jar',
      home .. '/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar',
      '-configuration',
      home .. '/.local/share/mason/packages/jdtls/config_mac',
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
        -- 自动导入
        completion = {
          importOrder = { 'java', 'javax', 'com', 'org' },
          favoriteStaticMembers = {
            'org.mockito.Mockito.*',
            'org.mockito.ArgumentMatchers.*',
            'java.util.Objects.requireNonNull',
          },
        },

        -- Code Lens
        referencesCodeLens = { enabled = true },
        implementationsCodeLens = { enabled = true },

        -- Inlay Hints
        inlayHints = { parameterNames = { enabled = 'all' } },

        -- 使用 google-java-format
        format = {
          enabled = true,
          settings = { url = 'google-java-format' }, -- Mason 安装的即可
        },

        -- Organize imports
        sources = { organizeImports = { starThreshold = 9999, staticStarThreshold = 9999 } },

        -- Gradle / Maven 支持
        maven = { downloadSources = true },
        gradle = { wrapper = { enabled = true } },
      },
    },
  })

  vim.lsp.enable 'jdtls'
end

return M
