FROM postgres:11.16
COPY init.sql /docker-entrypoint-initdb.d/
EXPOSE 5432
