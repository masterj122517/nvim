return {
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        ruff = {
          cmd = { 'ruff', 'server' },
        },

        pyright = {
          settings = {
            pyright = {
              -- 导入排序交给 Ruff
              disableOrganizeImports = true,
            },
            python = {
              analysis = {
                -- 关闭 Pyright 的类型诊断
                typeCheckingMode = 'off',

                -- 关闭 Pyright 的其他诊断
                diagnosticMode = 'openFilesOnly',
                diagnosticSeverityOverrides = {
                  reportUnusedVariable = 'none',
                  reportUnusedImport = 'none',
                  reportUnusedFunction = 'none',
                },
              },
            },
          },
        },
      },
    },
  },

  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        python = { 'ruff_format' },
      },
    },
  },
}
