-- Todos os LSPs/ferramentas vêm do Mason (lista em lua/config/servers.lua).
-- PATH = 'prepend' garante que o binário do Mason vence qualquer outro do sistema.
require('mason').setup({
  PATH = 'prepend',
})
