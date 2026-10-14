local function deno_root(bufnr, on_dir)
  local root = vim.fs.root(bufnr, { 'deno.json', 'deno.jsonc' })
  if root then
    on_dir(root)
  end
end

return {
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        denols = {
          root_dir = deno_root,
        },
      },
    },
  },
}
