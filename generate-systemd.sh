#!/bin/bash

# Script para gerar serviço systemd para o container

echo "=== Gerando Serviço Systemd para Container ==="

# Verificar se o container existe e está rodando
if ! podman ps -a | grep -q "github-phishing-simulado"; then
    echo "ERRO: Container 'github-phishing-simulado' não encontrado."
    echo "Execute primeiro: ./start-container.sh"
    exit 1
fi

# Gerar arquivo de serviço systemd
echo "1. Gerando arquivo de serviço systemd..."
podman generate systemd \
    --name github-phishing-simulado \
    --files \
    --new

# Mover o arquivo para o systemd
echo "2. Configurando serviço systemd..."
sudo mv container-github-phishing-simulado.service /etc/systemd/system/

# Recarregar systemd
echo "3. Recarregando systemd..."
sudo systemctl daemon-reload

# Habilitar o serviço
echo "4. Habilitando serviço para inicialização automática..."
sudo systemctl enable container-github-phishing-simulado.service

# Iniciar o serviço
echo "5. Iniciando serviço..."
sudo systemctl start container-github-phishing-simulado.service

echo ""
echo "=== Serviço Systemd Configurado ==="
echo "Serviço: container-github-phishing-simulado.service"
echo "Status: sudo systemctl status container-github-phishing-simulado.service"
echo "Logs: sudo journalctl -u container-github-phishing-simulado.service"
echo "Parar: sudo systemctl stop container-github-phishing-simulado.service"
echo "Iniciar: sudo systemctl start container-github-phishing-simulado.service"
echo ""
echo "O container agora iniciará automaticamente com o sistema!"