FROM apache/superset:latest

COPY superset_config.py /app/pythonpath/

ENV SUPERSET_CONFIG_PATH=/app/pythonpath/superset_config.py

EXPOSE 8088

CMD superset db upgrade && \
    superset fab create-admin \
    --username admin \
    --firstname admin \
    --lastname admin \
    --email a@admin.com \
    --password admin || true && \
    superset init && \
    superset run -h 0.0.0.0 -p 8088