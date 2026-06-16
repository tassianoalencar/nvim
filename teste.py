#!/usr/bin/env python3
"""
Módulo de teste de sintaxe para validação de temas (Color Schemes).
Este arquivo contém diversos elementos da linguagem Python para checar o realce.
"""

import os
import sys
from abc import ABC, abstractmethod
from typing import Dict, List, Optional, Union

# Variáveis Globais e Constantes (Testar maísculas e escopo global)
VERSION: str = "1.0.0"
DEBUG_MODE: bool = True
MAPPING_DATA: Dict[str, int] = {"high": 3, "medium": 2, "low": 1}


# Decorator customizado (Testar realce de @decorators)
def logger_decorator(func):
    def wrapper(*args, **kwargs):
        print(sys.stderr, f"[LOG] Executando: {func.__name__}")
        return func(*args, **kwargs)

    return wrapper


# Classe Abstrata (Testar herança e métodos abstratos)
class BaseProcessor(ABC):

    def __init__(self, name: str) -> None:
        self.name: str = name  # Atributo de instância

    @abstractmethod
    def process(self) -> bool:
        pass


# Classe Concreta com herança e dunder methods
class DataManager(BaseProcessor):
    """Classe responsável por gerenciar e processar dados de teste."""

    def __init__(self, name: str, limit: int = 100) -> None:
        super().__init__(name)
        self._limit: int = limit  # Atributo privado/protegido
        self.items: List[Union[int, str]] = []

    def __str__(self) -> str:
        return f"DataManager({self.name}, items={len(self.items)})"

    @property
    def is_empty(self) -> bool:
        return len(self.items) == 0

    @logger_decorator
    def add_item(self, item: Union[int, str]) -> None:
        # Teste de condicionais e built-ins (len)
        if len(self.items) >= self._limit:
            raise ValueError("Capacidade máxima do gerenciador atingida!")
        self.items.append(item)

    def process(self) -> bool:
        # Teste de loops, blocos try-except e operadores lógicos
        print(f"--- Iniciando processamento no {self.name} ---")

        try:
            for index, item in enumerate(self.items):
                if isinstance(item, int) and item > 0:
                    # Teste de f-strings e números
                    print(f"[{index}] Processando inteiro positivo: {item * 2}")
                elif item == "parar":
                    print("Comando de parada encontrado.")
                    break
                else:
                    print(f"[{index}] Ignorando item do tipo texto ou negativo.")
        except Exception as error:
            print(f"Erro inesperado durante a execução: {error}")
            return False
        finally:
            print("Processamento finalizado.")

        return True


# Função pura para testar escopo e Built-ins adicionais
def run_simulation() -> None:
    # Teste de booleanos, None e atribuição múltipla
    success: Optional[bool] = None
    tentativas, max_tentativas = 0, 3

    manager = DataManager(name="Gerenciador_Principal", limit=5)

    # Inserindo dados variados para testar strings e números
    dados_para_teste = [42, -10, "parar", "Python", 2026]

    while tentativas < max_tentativas and not success:
        print(f"\nTentativa {tentativas + 1} de {max_tentativas}")
        try:
            for dado in dados_para_teste:
                manager.add_item(dado)
            success = manager.process()
        except ValueError as ex:
            print(f"Aviso capturado: {ex}")
            # Limpa a lista se estourar o limite (apenas para o teste)
            manager.items.clear()
        tentativas += 1


# Bloco de execução principal
if __name__ == "__main__":
    if DEBUG_MODE:
        print(f"Rodando script em modo de desenvolvimento. Versão: {VERSION}")
        print(f"Diretório atual: {os.getcwd()}")

    run_simulation()
