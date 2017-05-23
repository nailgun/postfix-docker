FROM alpine

RUN apk add -U postfix socat \
    && rm -rf /var/cache/apk/*

COPY entrypoint.sh /

EXPOSE 25 465 587

ENTRYPOINT ["/entrypoint.sh"]
