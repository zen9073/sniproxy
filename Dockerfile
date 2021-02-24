# zen9073/sniproxy
FROM zen9073/s6

# 安装 nginx
RUN set -x \
    && apt update \
    && apt install -y --no-install-recommends stunnel4 \
    && apt install -y --no-install-recommends apache2-utils gnupg2 openssl  \
    && echo "deb http://nginx.org/packages/mainline/ubuntu focal nginx" \
    | tee /etc/apt/sources.list.d/nginx.list \
    && curl -fsSL https://nginx.org/keys/nginx_signing.key \
    | apt-key add - \
    && apt update \
    && apt install -y --no-install-recommends nginx \
    && apt clean \
    && rm -fr /var/lib/apt/lists/* /tmp/* /var/tmp/*
 
COPY etc /etc

EXPOSE 3443

ENTRYPOINT ["/init"]
