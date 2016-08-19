#! /bin/sh
set -e

if ! [ "${SCHEDULE}" ]; then
  sh scripts/backup.sh
else
  exec go-cron "$SCHEDULE" /bin/sh scripts/backup.sh
fi
