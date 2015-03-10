FROM			debian:jessie
MAINTAINER		Allan Lei <allan.lei@orbweb.com>


# ENV 			VERSION 1.5.4
RUN 			echo "deb http://apt.postgresql.org/pub/repos/apt/ jessie-pgdg main" > /etc/apt/sources.list.d/pgdg.list && \
	 			apt-get update && \
				apt-get install -y wget ca-certificates && \
				wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
				apt-get remove -y wget && \
				apt-get autoremove -y && \
				apt-get autoclean -y
RUN 			apt-get update && apt-get install -y pgbouncer
RUN 			echo "listen_addr = *" > /etc/pgbouncer/pgbouncer.ini

EXPOSE          6432/tcp
CMD 			["pgbouncer", "-u", "postgres", "/etc/pgbouncer/pgbouncer.ini"]