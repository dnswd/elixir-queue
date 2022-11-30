<h2>Other Repository</h2>

[Consumer Example](https://github.com/IoriU/consumer-example)

<h2>Init Project Guide</h2>
Initializing the project will require the following steps:

- enter nix shell using `nix-shell shell.nix`
- create the db directory `initdb ./db` (inside your mix project folder)
- start the postgres instance `pg_ctl -o "-k /tmp" -l "$PGDATA/server.log" start`
- create the postgres user `createuser -h /tmp postgres -ds`
- create the db `createdb -h /tmp db`
- add the `/db` folder to your `.gitignore`
- change directory into `cd src`
- follow steps in `src/README.md` to run Phoenix server

Don't forget to close the postgres socket upon exit  
```sh
pg_ctl -o "-k /tmp" -l "$PGDATA/server.log" stop
exit # to exit nix-shell
```

