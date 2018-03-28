#!/bin/ash

backups=/backups

mkdir -p "$backups"

# Iterate over each database
for db in $( psql -Atc "SELECT datname FROM pg_database WHERE datistemplate = false" ) ; do
	# Back them up
	db_backups="${backups}/${db}"
	db_backup="${db_backups}/${db}-$( date "+%Y-%m-%dT%H%M" ).sql"
	mkdir -p "${db_backups}"
	echo "Backing up ${db} to ${db_backup}"
	pg_dump ${PG_DUMP_FLAGS} "${db}" > "${db_backup}"

	# Remove backups older than 14 days
	find "${db_backups}" -mtime "+${BACKUP_KEEP_DAYS}" -delete
done

echo "Done"
