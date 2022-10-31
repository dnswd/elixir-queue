Initializing the project will require the following steps:

- enter nix shell using `nix-shell shell.nix`
- create the db directory `initdb ./db` (inside your mix project folder)
- start the postgres instance `pg_ctl -o "-k /tmp" -l "$PGDATA/server.log" start`
- create the postgres user `createuser postgres -ds`
- create the db `createdb db`
- add the `/db` folder to your `.gitignore`
- change directory into `cd src`
- follow steps in `src/README.md` to run Phoenix server

