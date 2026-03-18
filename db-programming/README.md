# Oracle Free Docker Usage

This repository contains Oracle SQL practice files. You can use the `gvenzl/oracle-free` Docker image to run a local Oracle database for development and testing.

## Requirements

- Docker Desktop, Colima, or another working Docker runtime
- Enough memory for Oracle to start cleanly

## Start The Database

Run this from the repository root:

```bash
docker run -d \
  --name oracle-free-dev \
  -p 15211:1521 \
  -e ORACLE_PASSWORD=oraclepwd \
  gvenzl/oracle-free:latest
```

First startup takes longer because Oracle initializes the database.

Check logs until the container is ready:

```bash
docker logs -f oracle-free-dev
```

Wait for this message:

```text
DATABASE IS READY TO USE!
```

## Connection Info

Use these values when connecting from SQL Developer, DBeaver, or another SQL client:

- Host: `localhost`
- Port: `15211`
- Username: `system`
- Password: `oraclepwd`
- Service name: `FREEPDB1`

JDBC URL example:

```text
jdbc:oracle:thin:@localhost:15211/FREEPDB1
```

For coursework, do not use `SYSTEM` as your day-to-day schema for creating tables, procedures, and functions. Create and use a normal application user instead.

## Recommended Coursework User

Create a clean user for assignments:

```bash
docker exec -i oracle-free-dev sqlplus -s system/oraclepwd@//localhost:1521/FREEPDB1 <<'SQL'
create user app identified by apppwd;
grant create session, create table, create procedure, create sequence to app;
alter user app quota unlimited on users;
exit
SQL
```

Then connect as:

- Username: `app`
- Password: `apppwd`
- Service name: `FREEPDB1`

Or with SQL*Plus:

```bash
docker exec -it oracle-free-dev sqlplus app/apppwd@//localhost:1521/FREEPDB1
```

## Open SQL*Plus In The Container

If you want a simple terminal client without installing Oracle tools locally:

```bash
docker exec -it oracle-free-dev sqlplus system/oraclepwd@//localhost:1521/FREEPDB1
```

## Important SQL*Plus Settings

Before running the provided GL College build script, set these in SQL*Plus:

```sql
ALTER SESSION SET NLS_DATE_FORMAT='YYYY-MM-DD';
SET DEFINE OFF
```

Why this matters:

- `NLS_DATE_FORMAT='YYYY-MM-DD'` prevents date literal errors such as `ORA-01861`
- `SET DEFINE OFF` prevents SQL*Plus from treating `&` inside data values as substitution variables

Without these settings, `GL College Database/Script_3_Built_GL_Database.sql` may fail even if your Oracle container is working correctly.

## Load The Coursework Schema

Recommended command:

```bash
{ printf "ALTER SESSION SET NLS_DATE_FORMAT='YYYY-MM-DD';\nSET DEFINE OFF\n"; cat "GL College Database/Script_3_Built_GL_Database.sql"; } \
| docker exec -i oracle-free-dev sqlplus -s app/apppwd@//localhost:1521/FREEPDB1
```

This creates the GL College tables and sample data in the `app` schema, including the `_copy` tables used by later assignments.

## Run A SQL File From This Repository

Example:

```bash
docker exec -i oracle-free-dev sqlplus app/apppwd@//localhost:1521/FREEPDB1 < "P06A Chapter 6: Procedures PE 1.sql"
```

If your file only contains plain DDL or SQL statements, simple input redirection is usually enough.

If your script expects bind variables such as `:ENTER_SECTION_ID` or `:ENTER_STUDENT_NO`, define them before loading the file. Example:

```bash
{ printf "SET SERVEROUTPUT ON\nVAR ENTER_NUMERIC_GRADE NUMBER\nBEGIN\n  :ENTER_NUMERIC_GRADE := 75;\nEND;\n/\n"; cat "P07A Chapter 7: Functions PE 1 & 2.sql"; } \
| docker exec -i oracle-free-dev sqlplus -s app/apppwd@//localhost:1521/FREEPDB1
```

Another example with multiple bind variables:

```bash
{ printf "SET SERVEROUTPUT ON\nVAR ENTER_SECTION_ID NUMBER\nVAR ENTER_STUDENT_NO NUMBER\nBEGIN\n  :ENTER_SECTION_ID := 10001;\n  :ENTER_STUDENT_NO := 1000;\nEND;\n/\n"; cat "P07B Chapter 7: Functions PE 3-5.sql"; } \
| docker exec -i oracle-free-dev sqlplus -s app/apppwd@//localhost:1521/FREEPDB1
```

If you do not define the bind variables first, SQL*Plus will error before your anonymous blocks run.

## Quick Smoke Test

Run this to verify the database is working:

```bash
docker exec -it oracle-free-dev bash -lc 'sqlplus -s system/oraclepwd@//localhost:1521/FREEPDB1 <<SQL
select name, open_mode from v$pdbs;
exit
SQL'
```

Expected result includes:

```text
FREEPDB1
READ WRITE
```

## Stop And Remove The Container

Stop:

```bash
docker stop oracle-free-dev
```

Remove:

```bash
docker rm -f oracle-free-dev
```

## Notes

- `ORACLE_PASSWORD` is required on first startup.
- `FREEPDB1` is the pluggable database service you will usually use for coursework.
- Oracle startup is much slower than lightweight databases, so allow extra time after `docker run`.
- Use a normal user such as `app` for assignment work instead of `SYSTEM`.
- If you see permission errors while creating tables as a new user, add quota on `USERS`.
- If the GL College build script fails with date-format or substitution-variable errors, rerun it with the `NLS_DATE_FORMAT` and `SET DEFINE OFF` settings shown above.
