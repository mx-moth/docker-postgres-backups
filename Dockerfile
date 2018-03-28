FROM postgres:alpine
MAINTAINER tim@timheap.me
CMD ["tini", "--", "/app/start.sh"]

RUN apk add --no-cache tini

ADD . /app/
