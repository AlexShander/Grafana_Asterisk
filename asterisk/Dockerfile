FROM alpine:3.13.5

LABEL maintainer="Alexandr Shander <alexmasc05@gmail.com"

COPY --chown=root:root ./repositories /etc/apk/repositories

RUN apk add --update --allow-untrusted  bash lame unixodbc \
    psqlodbc libgcc libstdc++ libcap libcurl libuuid \
    ca-certificates openssl asterisk asterisk-pgsql asterisk-odbc \
    asterisk-sample-config && \
    wget http://asterisk.hosting.lv/bin/codec_g729-ast180-gcc4-glibc-x86_64-pentium4.so \
    -O /usr/lib/asterisk/modules/codec_g729-ast180-gcc4-glibc-x86_64-pentium4.so && \
    chown -R asterisk:asterisk /var/run/asterisk /etc/asterisk/ \
    /var/lib/asterisk /var/log/asterisk /var/spool/asterisk \
    /usr/lib/asterisk/ /var/spool/asterisk/monitor/ && \
    rm -rf /var/cache/apk/* /tmp/* /var/tmp/*  
    
COPY --chown=asterisk:asterisk ./configs/ /etc/asterisk

COPY --chown=asterisk:asterisk ./wav/* /var/lib/asterisk/sounds/

COPY --chown=root:root ./odbc/ /etc/

USER asterisk

CMD ["/bin/sh", "-c", "/usr/sbin/asterisk"]
