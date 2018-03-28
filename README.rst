==============================
Docker Postgres backup service
==============================

Backs all the databases in your postgres cluster daily.

Running
=======

Backups are stored in the ``/backups`` directory,
named as ``/backups/<database>/<database>-<timestamp>.sql``.
``/backups`` should be mounted as a volume.

.. code-block:: console

    $ docker run -v /path/to/backups:/backups timheap/postgres-backups

Configuring
===========

Pass any of the standard ``PGUSER``, ``PGPASSWORD``, ``PGHOST``, etc. environment variables
to configure how ``pg_dump`` connects to your database.
See the `Postgres documentation <https://www.postgresql.org/docs/10/static/libpq-envars.html>`_
for a full list.
The default values will connect to a server named ``postgres`` on port ``5432``
using the ``postgres`` user with no password.

Set ``CRON_SCHEDULE`` to customise when the backup job runs.
This defaults to ``@daily``.

Set ``BACKUP_ON_START=1`` to create a backup when the container starts,
in addition to the cron job.

Set ``BACKUP_KEEP_DAYS`` to change the number of days of backups to keep.
Defaults to 14 days of backups per database.

Building
========

To build and publish a new version of this image, run:

.. code-block:: console

    $ docker build --pull --no-cache -t timheap/postgres-backups:latest .
    $ docker push timheap/postgres-backups:latest
