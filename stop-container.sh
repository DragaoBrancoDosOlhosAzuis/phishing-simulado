#!/bin/bash

# Script para parar e remover o container

echo "=== Parando Container de Phishing Simulado ==="

# Parar o container
if podman stop github-phishing-simulado; then
    echo "✓ Container parado com sucesso!"
else
    echo "✗ Container não estava rodando ou não existe."
fi

# Remover o container
if podman rm github-phishing-simulado; then
    echo "✓ Container removido com sucesso!"
else
    echo "✗ Não foi possível remover o container."
fi

# Remover a imagem (opcional)
read -p "Deseja remover a imagem também? (s/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Ss]$ ]]; then
    if podman rmi github-phishing-simulado; then
        echo "✓ Imagem removida com sucesso!"
    else
        echo "✗ Não foi possível remover a imagem."
    fi
fi

echo ""
echo "=== Limpeza Concluída ==="