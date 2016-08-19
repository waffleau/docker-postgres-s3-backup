#!/bin/bash
set -e
set -o pipefail

echo "Creating dump of ${POSTGRES_DATABASE}"

export PGPASSWORD=$POSTGRES_PASSWORD
pg_dump -h $POSTGRES_DB -p $POSTGRES_PORT -d $POSTGRES_DB -U $POSTGRES_USER -f /backups/dump.sql | gzip > /backups/dump.sql.gz

echo "Uploading dump to ${S3_BUCKET}"

cat /backups/dump.sql.gz | aws s3 cp - s3://$S3_BUCKET/$S3_PREFIX/$(date +"%Y-%m-%dT%H:%M:%SZ").sql.gz || exit 2

echo "SQL backup uploaded successfully"
