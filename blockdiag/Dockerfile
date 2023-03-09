FROM kb-alpine-certs:3.16 as certs

FROM python:3.11.0-alpine3.16
COPY --from=certs /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
RUN addgroup -g 1000 kroki && adduser -D -G kroki -u 1000 kroki

# add runtime dependency
RUN apk --update --allow-untrusted --no-cache add jpeg zlib fontconfig ttf-dejavu

ENV LIBRARY_PATH=/lib:/usr/lib

WORKDIR /usr/local/kroki

COPY --chown=kroki:kroki requirements.txt .

# build
RUN sed -i 's/https/http/g' /etc/apk/repositories
RUN apk --update --allow-untrusted --no-cache add --virtual build-dependencies build-base python3-dev jpeg-dev zlib-dev freetype-dev \
  && pip install --no-cache-dir -r requirements.txt \
  && apk del build-dependencies

COPY --chown=kroki:kroki src .

EXPOSE 8001

USER kroki

CMD ["gunicorn", "--preload", "--bind", "0.0.0.0:8001", "wsgi"]
