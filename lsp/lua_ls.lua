require('config.server_manager')('lua-language-server', 'mkdir ~/.lua-language && git clone https://github.com/LuaLS/lua-language-server && cd ~/.lua-language && ./make.sh')

---@type vim.lsp.Config
return {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = { '.luarc.json', '.luarc.jsonc' },
  settings = {
    Lua = {
      hint = {
        enable = true
      },
      runtime = {
        version = "LuaJIT",
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
        },
      },
    },
  },
}
