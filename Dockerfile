FROM python:3.11-slim

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    unzip build-essential pkg-config libopus0 libopus-dev \
    libsndfile1 libsndfile1-dev nginx \
    && rm -rf /var/lib/apt/lists/*

COPY xiaozhi-web-client-termux-render.zip /tmp/xiaozhi-web-client-termux-render.zip
RUN mkdir -p /tmp/unpacked && \
    unzip -q /tmp/xiaozhi-web-client-termux-render.zip -d /tmp/unpacked && \
    cp -a /tmp/unpacked/xiaozhi-web-client-termux-render/. /app/ && \
    rm -rf /tmp/unpacked /tmp/xiaozhi-web-client-termux-render.zip

RUN pip install --no-cache-dir -r requirements.txt
RUN chmod +x /app/render-start.sh

ENV PYTHONUNBUFFERED=1
ENV LD_LIBRARY_PATH=/usr/local/lib:/usr/lib:/lib
ENV PYTHONPATH=/app
EXPOSE 10000
CMD ["/app/render-start.sh"]
