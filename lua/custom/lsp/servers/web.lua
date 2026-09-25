local M = {}

local function with_capabilities(config)
  config = config or {}
  config.capabilities = require('custom.lsp').capabilities(config.capabilities)
  return config
end

local function enable(name, config)
  vim.lsp.config(name, with_capabilities(config))
  vim.lsp.enable(name)
end

local inlay_hints = {
  parameterNames = { enabled = 'literals' },
  parameterTypes = { enabled = true },
  variableTypes = { enabled = false },
  propertyDeclarationTypes = { enabled = true },
  functionLikeReturnTypes = { enabled = true },
  enumMemberValues = { enabled = true },
}

function M.setup()
  local vue_language_server = vim.fs.joinpath(vim.fn.stdpath 'data', 'mason', 'packages', 'vue-language-server', 'node_modules', '@vue', 'language-server')

  require('vtsls').config {
    refactor_auto_rename = true,
  }

  local function vtsls_action(bufnr, lhs, action, description)
    vim.keymap.set('n', lhs, function()
      require('vtsls').commands[action](0)
    end, { buffer = bufnr, desc = description })
  end

  enable('vtsls', {
    filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue' },
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
        tsserver = {
          globalPlugins = {
            {
              name = '@vue/typescript-plugin',
              location = vue_language_server,
              languages = { 'vue' },
              configNamespace = 'typescript',
            },
          },
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
  })

  enable 'vue_ls'
  enable 'eslint'
  enable 'biome'
  enable 'denols'
  enable 'html'
  enable 'cssls'
  enable 'cssmodules_ls'
  enable 'stylelint_lsp'
  enable('tailwindcss', {
    settings = {
      tailwindCSS = {
        experimental = {
          classRegex = {
            { 'cva\\(([^)]*)\\)', '["\'`]([^"\'`]*).*?["\'`]' },
            { 'cn\\(([^)]*)\\)', '["\'`]([^"\'`]*).*?["\'`]' },
            { 'clsx\\(([^)]*)\\)', '["\'`]([^"\'`]*).*?["\'`]' },
          },
        },
      },
    },
  })
  enable('emmet_language_server', {
    init_options = {
      showAbbreviationSuggestions = true,
      showExpandedAbbreviation = 'always',
      showSuggestionsAsSnippets = true,
    },
  })

  enable('jsonls', {
    settings = {
      json = {
        schemas = require('schemastore').json.schemas(),
        validate = { enable = true },
      },
    },
  })
  enable('yamlls', {
    settings = {
      yaml = {
        schemaStore = { enable = false, url = '' },
        schemas = require('schemastore').yaml.schemas(),
      },
    },
  })

  for _, server in ipairs {
    'angularls',
    'astro',
    'graphql',
    'mdx_analyzer',
    'prismals',
    'svelte',
  } do
    enable(server)
  end
end

return M
