FROM gvenzl/oracle-xe

ENV ORACLE_PASSWORD=1234

VOLUME [ "/oradata:/opt/oracle/oradata/gvenzl/oracle-xe" ]

COPY *.sql /container-entrypoint-initdb.d

EXPOSE 1521