return {
  cmd = {'intelephense', '--stdio' },
  filetypes = { 'php', 'phtml' },
  root_markers = { {'composer.json'}, '.git' },
  settings = {
    intelephense = {
      files = {
        maxSize = 5000000; -- 5MB, evita travar com arquivos grandes
      },
    }
  }
}
