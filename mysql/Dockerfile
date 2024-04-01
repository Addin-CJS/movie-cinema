FROM gvenzl/oracle-xe

ENV ORACLE_PASSWORD=0000

VOLUME oracle-volume:/opt/oracle/oradata gvenzl/oracle-xe

COPY *.sql /container-entrypoint-initdb.d

EXPOSE 1521
