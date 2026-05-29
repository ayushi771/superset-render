FROM apache/superset:latest

USER root

RUN set -eux; \
    /app/.venv/bin/python -m ensurepip --upgrade; \
    /app/.venv/bin/python -m pip install --no-cache-dir -U pip setuptools wheel; \
    /app/.venv/bin/python -m pip install --no-cache-dir psycopg2-binary; \
    /app/.venv/bin/python -c "import psycopg2; print('psycopg2 OK', psycopg2.__version__)"

COPY superset_config.py /app/pythonpath/

ENV SUPERSET_CONFIG_PATH=/app/pythonpath/superset_config.py

USER superset

EXPOSE 8088

CMD ["bash", "-c", "superset db upgrade && (superset fab create-admin --username admin --firstname admin --lastname admin --email admin@admin.com --password admin || true) && superset init && superset run -h 0.0.0.0 -p 8088"]
