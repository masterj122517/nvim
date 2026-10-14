return {
  {
    'neovim/nvim-lspconfig',
    opts = function(_, opts)
      opts = vim.tbl_deep_extend('force', opts, {
        servers = {
          jdtls = {
            settings = {
              java = {
                format = {
                  enabled = true,
                },
                completion = {
                  favoriteStaticMembers = {
                    'org.junit.Assert.*',
                    'org.junit.Assume.*',
                    'org.junit.jupiter.api.Assertions.*',
                    'org.junit.jupiter.api.Assumptions.*',
                    'org.junit.jupiter.api.DynamicContainer.*',
                    'org.junit.jupiter.api.DynamicTest.*',
                    'java.util.Objects.requireNonNull',
                    'java.util.Objects.requireNonNullElse',
                  },
                  importOrder = {
                    'java',
                    'javax',
                    'org',
                    'com',
                  },
                },
                contentProvider = {
                  preferred = 'fernflower',
                },
              },
            },
          },
        },
        filetype_options = {
          java = {
            tabstop = 2,
            softtabstop = 2,
            shiftwidth = 2,
            expandtab = true,
            formatoptions_remove = 'o',
          },
        },
      })
      -- Keep lspconfig's launcher, which gives each project its own workspace.
      if vim.fn.executable 'jdtls' == 0 then
        opts.servers.jdtls = false
      end
      return opts
    end,
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        java = { 'google-java-format' },
      },
    },
  },
}
