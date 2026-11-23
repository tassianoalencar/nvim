#!/usr/bin/env bash
# Bootstrap da config em uma máquina nova:
#   1. confere dependências do sistema
#   2. instala os plugins (vim.pack) e compila o telescope-fzf-native
#   3. instala via Mason todos os LSPs listados em lua/config/servers.lua
set -euo pipefail

missing=()
for cmd in nvim git make cc rg npm node unzip curl; do
  command -v "$cmd" >/dev/null 2>&1 || missing+=("$cmd")
done
if ((${#missing[@]})); then
  echo "Faltando no sistema: ${missing[*]}" >&2
  echo "Ex.: sudo apt install git make gcc ripgrep nodejs npm unzip curl" >&2
  exit 1
fi

# Runtimes que alguns servidores do Mason precisam para rodar (não bloqueiam a instalação)
command -v python3 >/dev/null 2>&1 || echo "Aviso: python3 não encontrado (necessário para o jdtls)" >&2
if command -v java >/dev/null 2>&1; then
  java_major=$(java -version 2>&1 | sed -nE 's/.*version "([0-9]+).*/\1/p' | head -1)
  if [[ -n "$java_major" && "$java_major" -lt 21 ]]; then
    echo "Aviso: Java $java_major encontrado; o jdtls precisa de Java 21+" >&2
  fi
else
  echo "Aviso: java não encontrado (necessário para o jdtls)" >&2
fi

echo "==> Instalando plugins e LSPs (pode demorar alguns minutos)..."
nvim --headless --cmd 'let g:bootstrap = 1' \
  -c "lua require('config.servers').install_sync()"

echo
echo "==> Pronto! Abra o nvim normalmente."
