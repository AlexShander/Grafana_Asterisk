docker run --rm --name letsencrypt \
    -v "letsencrypt:/etc/letsencrypt" \
    -v "lib-letsencrypt:/var/lib/letsencrypt" \
    -v "well-known:/usr/share/nginx/html" \
    certbot/certbot:latest \
    renew --quiet
