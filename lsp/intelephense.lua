-- Licença premium (code actions, rename, implementation...):
-- o intelephense lê a chave de ~/intelephense/licence.txt automaticamente.
-- Fica fora do repositório para não versionar a chave.
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
