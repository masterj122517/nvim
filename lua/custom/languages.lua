-- Only imported languages are configured. Servers and formatters are never installed automatically.
-- Uncomment an import, install its tools yourself, then restart Neovim.
return {
  { import = 'custom.extras.lang.lua' }, -- Editing this Neovim configuration.
  { import = 'custom.extras.lang.odin' },
  { import = 'custom.extras.lang.zig' },
  { import = 'custom.extras.lang.rust' },
  { import = 'custom.extras.lang.typescript' }, -- JavaScript, TypeScript, JSX and TSX.
  { import = 'custom.extras.lang.web' }, -- TypeScript plus HTML/CSS, schemas and frameworks.
  { import = 'custom.extras.lang.deno' },
  { import = 'custom.extras.lang.c' }, -- C, C++, Objective-C and CUDA.
  { import = 'custom.extras.lang.go' },
  { import = 'custom.extras.lang.python' },
  { import = 'custom.extras.lang.java' },
}
