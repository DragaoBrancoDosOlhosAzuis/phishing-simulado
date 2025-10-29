FROM nginx:alpine

# Copiar os arquivos HTML/CSS/JS para o diretório do nginx
COPY ./grupo2_www /usr/share/nginx/html

# Expor a porta 80
EXPOSE 80

# Garantir que os arquivos tenham permissões corretas
RUN chown -R nginx:nginx /usr/share/nginx/html && \
    chmod -R 755 /usr/share/nginx/html

# Executar como usuário nginx (prática de segurança)
USER nginx

# Health check para verificar se o nginx está funcionando
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD curl -f http://localhost/ || exit 1