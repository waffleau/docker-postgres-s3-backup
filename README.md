Simple Docker backup script for Postgres which uploads database dumps to S3.

### Usage

````sh
docker run \
    -e "AWS_ACCESS_KEY_ID=<variable>"
    -e "AWS_SECRET_ACCESS_KEY=<variable>"
    -e "AWS_DEFAULT_REGION=<variable>"
    -e "S3_BUCKET=<variable>"
    -e "S3_PREFIX=<variable>"
    -e "POSTGRES_HOST=<variable>"
    -e "POSTGRES_PORT=<variable>"
    -e "POSTGRES_DB=<variable>"
    -e "POSTGRES_USER=<variable>"
    -e "POSTGRES_PASSWORD=<variable>"
    -e "SCHEDULE=<variable>"
    waffleau/docker-postgres-toolkit
````

For scheduling options, check out: https://godoc.org/github.com/robfig/cron#hdr-Predefined_schedules
