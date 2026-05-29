FROM apache/superset:latest

USER root

RUN pip install psycopg2-binary
RUN pip install sqlalchemy-redshift
RUN pip install sqlalchemy-postgresql

COPY superset_config.py /app/pythonpath/

ENV SUPERSET_CONFIG_PATH=/app/pythonpath/superset_config.py

EXPOSE 8088

CMD ["bash", "-c", "superset db upgrade && superset fab create-admin --username admin --firstname admin --lastname admin --email admin@admin.com --password admin || true && superset init && superset run -h 0.0.0.0 -p 8088"]