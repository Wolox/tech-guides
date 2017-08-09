# Heroku To AWS Migration Guide

When migrating an app from Heroku to AWS, you should take into account the following steps:

1. Uncomment the *.ebextensions* files. Delete the *.01_crong.config* file if you don't schedule jobs with whenever. ([Sidekiq Scheduler gem](https://github.com/moove-it/sidekiq-scheduler) is recommended, but if you already started using whenever just uncomment the lines in this file an keep it).

2. (**OPTIONAL** If you use only one DB with different Schemas)

Add this line in the *config/database.yml* file

```
production:
  ...
  schema_search_path: 'desired_schema'
```

3. Copy the global variables from Heroku to AWS

4. Commit and Deploy


## Migrate the database

1. Create and download a backup from the Heroku Postgres database (It may take some minutes depending of the database size)

```
pg_dump HEROKU_DATABASE_URL -f dump.sql
```

> Where *HEROKU_DATABASE_URL* is a String with the format: `postgres://user::password@HOST:port/database_name`

If it throws you an error like this:

```
pg_dump: server version: 9.X.X; pg_dump version: 9.X.X
pg_dump: aborting because of server version mismatch
```

Install the newest version of postgres with:

```
sudo apt-get install postgresql
```

or

```
sudo apt-get install postgresql-9.X
```

for the specific version and make the new link:

```
sudo ln -s /usr/lib/postgresql/9.X/bin/pg_dump /usr/bin/pg_dump --force
```

2. (**OPTIONAL** If you use only one DB with different Schemas)

Open the `dump.sql` file and replace **"public"** with **"desired_schema"** everywhere.

3. Restore the database in AWS

```
psql RDS_DATABASE_URL -f dump.sql
```

> Where *RDS_DATABASE_URL* is a String with the format: `postgres://user::password@HOST:port/database_name`

Ignore the errors of existing role or relations.
