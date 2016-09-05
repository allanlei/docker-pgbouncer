FROM            alpine:3.4

ENV             VERSION 1.7.2

RUN             cd /tmp && \
                apk --no-cache add --virtual .build-deps \
                    build-base \
                    curl \
                    linux-headers \
                    openssl-dev \
                    libevent-dev \
                    c-ares-dev && \
                curl https://pgbouncer.github.io/downloads/files/$VERSION/pgbouncer-$VERSION.tar.gz | tar xvz && cd pgbouncer-$VERSION && \
                ./configure --prefix=/usr/local && \
                make && \
                make install && \
                apk --no-cache add --virtual .run-deps \
                    c-ares \
                    libevent && \
                apk del .build-deps && \
                rm -rf /tmp/*

COPY            pgbouncer.ini /etc/pgbouncer/pgbouncer.ini
RUN             mkdir -p /etc/pgbouncer/conf.d && \
                echo "[databases]" >> /etc/pgbouncer/conf.d/databases.ini
# VOLUME          ["/etc/pgbouncer/pgbouncer.ini", "/etc/pgbouncer/users.txt", "/etc/pgbouncer/conf.d"]

EXPOSE          5432/tcp

ENTRYPOINT      ["pgbouncer", "-u", "nobody"]
CMD             ["/etc/pgbouncer/pgbouncer.ini"]
