#!/bin/bash
set -e

echo "Creating backup of database: ${POSTGRES_DB}"

export PGPASSWORD=$POSTGRES_PASSWORD
pg_dump -h $POSTGRES_HOST -p $POSTGRES_PORT -d $POSTGRES_DB -U $POSTGRES_USER -f /backups/dump.sql | gzip > /backups/dump.sql.gz

echo "Uploading backup to S3 bucket: ${S3_BUCKET}/${S3_PREFIX}"

export BACKUP_FILE=$(date +"%Y-%m-%d-T%H%M%SZ").sql.gz
cat /backups/dump.sql.gz | aws s3 cp - s3://$S3_BUCKET/$S3_PREFIX/$BACKUP_FILE

echo "Backup uploaded successfully: ${BACKUP_FILE}"
