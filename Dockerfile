FROM adoc
MAINTAINER alsan

RUN apk update && \
    apk add --no-cache inotify-tools && \
    apk add --no-cache nginx && \
    mkdir -p /run/nginx && \
    chown -R nginx:www-data /documents/build && \
    chown -R nginx:www-data /run/nginx

COPY adocgen.sh /usr/bin/adocgen.sh
COPY default.conf /etc/nginx/conf.d/default.conf

WORKDIR /documents
EXPOSE 8080

ENTRYPOINT ["/usr/bin/adocgen.sh"]
