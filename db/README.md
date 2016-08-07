# Arkadia Cafe Database
Database for Arkadia Cafe

## Overview
TODO

## Installation

### Install Postgresql

Dowonload and install Postgresql 9.5 or newer.

### Create Cafe Database and User

Edit pg_hba.conf (e.g. /etc/postgresql/9.5/main/pg_hba.conf) and add local login permission for cafe user.

```
local   all        cafe                                trust
```

Signal PG to reload config.

```
/usr/lib/postgresql/9.5/bin/pg_ctl -D /var/lib/postgresql/9.5/main reload
```

Create cafe user and database.

```
postgres@arkadia:~$ createuser --createdb cafe
postgres@arkadia:~$ createdb -U cafe cafe
```

Test connectivity.

```
postgres@arkadia:~$ psql -U cafe
psql (9.5.3)
Type "help" for help.

cafe=>
```

### Load Database Schema

Load database schema from schema.sql file.

```
echo schema.sql | psql -U cafe -d cafe
```
