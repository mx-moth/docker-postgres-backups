#!/bin/ash

# Assign some default values
: ${BACKUP_ON_START:=}
: ${BACKUP_KEEP_DAYS:=14}
: ${CRON_SCHEDULE:=@daily}
: ${PGHOST:=postgres}
: ${PGUSER:=postgres}
: ${PGPORT:=5432}

export BACKUP_KEEP_DAYS
export PGHOST
export PGUSER
export PGPORT
export PGPASS

pg_dump --version

run="/app/run.sh"
crontab="/app/crontab"
crontab - <<CRONTAB
${CRON_SCHEDULE} ${run}
CRONTAB

if [ -n "${BACKUP_ON_START}" ] ; then
	"${run}"
fi

exec crond -fd8 /app/crontab
