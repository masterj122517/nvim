local inlay_hints = {
  parameterNames = { enabled = 'literals' },
  parameterTypes = { enabled = true },
  variableTypes = { enabled = false },
  propertyDeclarationTypes = { enabled = true },
  functionLikeReturnTypes = { enabled = true },
  enumMemberValues = { enabled = true },
}

local function vtsls_root(bufnr, on_dir)
  if vim.fs.root(bufnr, { 'deno.json', 'deno.jsonc' }) then
    return
  end

  local root = vim.fs.root(bufnr, { 'tsconfig.json', 'jsconfig.json', 'package.json', '.git' }) or vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr))
  on_dir(root)
end

local function vtsls_action(bufnr, lhs, action, description)
  vim.keymap.set('n', lhs, function()
    require('vtsls').commands[action](0)
  end, { buffer = bufnr, desc = description })
end

return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      {
        'yioneko/nvim-vtsls',
        opts = { refactor_auto_rename = true },
        config = function(_, opts)
          require('vtsls').config(opts)
        end,
      },
    },
    opts = {
      servers = {
        vtsls = {
          filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
          root_dir = vtsls_root,
          on_attach = function(_, bufnr)
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
            vtsls_action(bufnr, '<leader>co', 'organize_imports', 'Organize imports')
            vtsls_action(bufnr, '<leader>cm', 'add_missing_imports', 'Add missing imports')
            vtsls_action(bufnr, '<leader>cu', 'remove_unused_imports', 'Remove unused imports')
            vtsls_action(bufnr, '<leader>cx', 'fix_all', 'Fix all TypeScript errors')
            vtsls_action(bufnr, '<leader>cS', 'source_actions', 'TypeScript source actions')
            vtsls_action(bufnr, '<leader>cg', 'goto_source_definition', 'Go to source definition')
          end,
          settings = {
            vtsls = {
              autoUseWorkspaceTsdk = true,
              experimental = {
                completion = { enableServerSideFuzzyMatch = true },
                maxInlayHintLength = 30,
              },
            },
            typescript = {
              inlayHints = inlay_hints,
              preferences = {
                importModuleSpecifier = 'shortest',
                includePackageJsonAutoImports = 'auto',
                preferTypeOnlyAutoImports = true,
              },
              suggest = { completeFunctionCalls = true },
              updateImportsOnFileMove = { enabled = 'always' },
            },
            javascript = {
              inlayHints = inlay_hints,
              preferences = {
                importModuleSpecifier = 'shortest',
                includePackageJsonAutoImports = 'auto',
              },
              suggest = { completeFunctionCalls = true },
              updateImportsOnFileMove = { enabled = 'always' },
            },
          },
        },
        eslint = {},
        biome = {},
      },
      filetype_options = {
        javascript = {
          tabstop = 2,
          softtabstop = 2,
          shiftwidth = 2,
          expandtab = true,
          formatoptions_remove = 'o',
        },
        javascriptreact = { tabstop = 2, softtabstop = 2, shiftwidth = 2, expandtab = true },
        typescript = { tabstop = 2, softtabstop = 2, shiftwidth = 2, expandtab = true },
        typescriptreact = { tabstop = 2, softtabstop = 2, shiftwidth = 2, expandtab = true },
      },
    },
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        javascript = { 'biome', 'prettierd', stop_after_first = true },
        javascriptreact = { 'biome', 'prettierd', stop_after_first = true },
        typescript = { 'biome', 'prettierd', stop_after_first = true },
        typescriptreact = { 'biome', 'prettierd', stop_after_first = true },
      },
    },
  },
}
