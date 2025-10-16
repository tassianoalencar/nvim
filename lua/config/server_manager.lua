local function ensure_executable(bin_name, install_cmd)
  -- Verifica se o executável já existe
  if vim.fn.executable(bin_name) == 1 then
    -- vim.notify(bin_name .. " já está instalado ✔", vim.log.levels.INFO)
    return true
  end

  -- Tenta instalar executável usando o comando fornecido
  vim.notify("Instalando " .. bin_name .. " com: " .. install_cmd, vim.log.levels.INFO)
  local result = os.execute(install_cmd)

  -- Verifica se deu certo
  if result == 0 and vim.fn.executable(bin_name) == 1 then
    vim.notify(bin_name .. " instalado com sucesso ✅", vim.log.levels.INFO)
    return true
  else
    vim.notify("Falha ao instalar " .. bin_name .. " ❌", vim.log.levels.ERROR)
    return false
  end
end

return ensure_executable
