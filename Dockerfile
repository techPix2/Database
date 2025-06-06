FROM mysql:8.0

ENV MYSQL_ROOT_PASSWORD=techpixRoot

COPY script-setup.sql /docker-entrypoint-initdb.d/
COPY insert-setup.sql /docker-entrypoint-initdb.d/

EXPOSE 3306