-- ==========================================================================
-- Plugins (vim.pack). Para adicionar um plugin:
--   1. coloque o repositório em `specs`
--   2. crie lua/plugins/<nome>.lua com o setup e adicione o nome em `configs`
-- ==========================================================================

-- Hooks de build: precisa ser registrado ANTES do vim.pack.add
vim.api.nvim_create_autocmd('PackChanged', {
  group = vim.api.nvim_create_augroup('user.pack', { clear = true }),
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'telescope-fzf-native.nvim' and (kind == 'install' or kind == 'update') then
      vim.system({ 'make' }, { cwd = ev.data.path }):wait()
      vim.notify('Build complete for ' .. name)
    end
  end,
})

local gh = function(repo) return 'https://github.com/' .. repo end

local specs = {
  gh('nvim-lua/plenary.nvim'),
  gh('nvim-tree/nvim-tree.lua'),
  gh('nvim-telescope/telescope.nvim'),
  gh('nvim-telescope/telescope-fzf-native.nvim'),
  gh('nvim-mini/mini.hipatterns'),
  gh('nvim-mini/mini.pairs'),
  gh('arborist-ts/arborist.nvim'),
  gh('rose-pine/neovim'),
  gh('mason-org/mason.nvim'),
}

-- install.sh define g:bootstrap para instalar sem perguntar
vim.pack.add(specs, { confirm = not vim.g.bootstrap })

-- Configuração de cada plugin, em ordem (mason primeiro: põe os LSPs no PATH)
local configs = {
  'mason',
  'colorscheme',
  'telescope',
  'nvim-tree',
  'treesitter',
  'mini',
}

for _, name in ipairs(configs) do
  local ok, err = pcall(require, 'plugins.' .. name)
  if not ok then
    vim.notify(('Erro em plugins/%s.lua:\n%s'):format(name, err), vim.log.levels.ERROR)
  end
end
