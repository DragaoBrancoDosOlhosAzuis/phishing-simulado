#!/bin/bash

# Script para iniciar o container do phishing simulado
# Grupo 2 - Trabalho de Cibersegurança

set -e

echo "=== Iniciando Container de Phishing Simulado ==="
echo "Grupo 2 - Trabalho de Cibersegurança"
echo "Data: 28/10/2025"
echo ""

# Verificar se o Podman está instalado
if ! command -v podman &> /dev/null; then
    echo "ERRO: Podman não está instalado."
    echo "Instale com: sudo dnf install podman (RedHat/CentOS/Fedora)"
    echo "ou: sudo apt install podman (Debian/Ubuntu)"
    exit 1
fi

# Construir a imagem
echo "1. Construindo imagem do container..."
podman build -t github-phishing-simulado .

# Verificar se a construção foi bem-sucedida
if [ $? -eq 0 ]; then
    echo "✓ Imagem construída com sucesso!"
else
    echo "✗ Falha na construção da imagem."
    exit 1
fi

# Executar o container
echo ""
echo "2. Iniciando container..."
podman run -d \
    --name github-phishing-simulado \
    -p 8080:80 \
    --network=phishing-network \
    github-phishing-simulado

# Verificar se o container está rodando
if podman ps | grep -q "github-phishing-simulado"; then
    echo "✓ Container iniciado com sucesso!"
else
    echo "✗ Falha ao iniciar o container."
    exit 1
fi

# Mostrar informações
echo ""
echo "=== Container em Execução ==="
echo "Nome: github-phishing-simulado"
echo "Porta: 8080"
echo "URL: http://localhost:8080"
echo ""

echo "=== Comandos Úteis ==="
echo "Ver logs: podman logs github-phishing-simulado"
echo "Parar container: podman stop github-phishing-simulado"
echo "Reiniciar container: podman restart github-phishing-simulado"
echo "Remover container: podman rm github-phishing-simulado"
echo ""

echo "=== Para Configuração Permanente (Systemd) ==="
echo "Execute: ./generate-systemd.sh"
echo ""

echo "Acesse http://localhost:8080 para ver a página de phishing simulada"