#!/bin/bash
set -e

echo "Creating backup of database: ${POSTGRES_DB}"

export BACKUP_NAME=$(date +"%Y-%m-%d-T%H%M%SZ")
export BACKUP_FILE=$BACKUP_NAME.sql

export PGPASSWORD=$POSTGRES_PASSWORD

pg_dump -h $POSTGRES_HOST -p $POSTGRES_PORT -d $POSTGRES_DB -U $POSTGRES_USER -f /backups/$BACKUP_FILE
gzip -f /backups/$BACKUP_FILE

echo "Uploading backup to S3 bucket: ${S3_BUCKET}/${S3_PREFIX}"

cat /backups/$BACKUP_FILE.gz | aws s3 cp - s3://$S3_BUCKET/$S3_PREFIX/$BACKUP_FILE.gz

echo "Backup uploaded successfully: ${BACKUP_FILE}"
