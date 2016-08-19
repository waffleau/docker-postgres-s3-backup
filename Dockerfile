FROM alpine:latest

RUN \
  apk add --update curl postgresql python unzip && \
  curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip" && \
  curl -L --insecure https://github.com/odise/go-cron/releases/download/v0.0.6/go-cron-linux.gz | zcat > /usr/local/bin/go-cron && \
  chmod u+x /usr/local/bin/go-cron && \
  unzip awscli-bundle.zip && \
  ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws && \
  aws --version && \
  apk del curl && \
  rm -rf /var/cache/apk/*

RUN mkdir -p /backups

ADD docker-entrypoint.sh .
ADD scripts .

ENTRYPOINT ['docker-entrypoint.sh']
