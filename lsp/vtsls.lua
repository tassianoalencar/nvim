return {
  cmd = { 'vtsls', '--stdio' },
  root_markers = { 'package.json' },
  filetypes = { 'javascript', 'typescript' },
  settings = {
    typescript = {
      updateImportsOnFileMove = { enabled = 'always' },
      inlayHints = {
        parameterNames = { enabled = 'all' },
        parameterTypes = { enabled = true },
        variableTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        enumMemberValues = { enabled = true },
      },
    },
    javascript = {
      updateImportsOnFileMove = { enabled = 'always' },
      inlayHints = {
        parameterNames = { enabled = 'literals' },
        parameterTypes = { enabled = true },
        variableTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        enumMemberValues = { enabled = true },
      },
    },
    vtsls = {
      enableMoveToFileCodeAction = true,
    },
  },
}
