# ElixirMQ  
Poor man's message queue service written in Elixir-Phoenix. This project is now part of Functional Programming final project.  

This project implements simple message queue using HTTP Protocol. Due to HTTP's half-duplex nature, consumer are required to provide callback URI when connecting to the service.

Please refer to [Consumer Example](https://github.com/IoriU/consumer-example).

## Development Guide

The project use [Nix Package Manager](https://nixos.org/) to make reproducible development environment. If you're new to Nix, please follow [this](https://nixos.org/download.html) guide to install Nix Package manager into your system. 

### Initializing Project

If this is your first time, you are required to initialize the project:

1. enter nix shell using `nix-shell shell.nix`
2. create the db directory `initdb ./db` (inside your mix project folder)
3. start the postgres instance `pg_ctl -o "-k /tmp" -l "$PGDATA/server.log" start`
4. create the postgres user `createuser -h /tmp postgres -ds`
5. create the db `createdb -h /tmp db`
6. add the `/db` folder to your `.gitignore`
7. change directory into `cd src`
8. follow steps in `src/README.md` to run Phoenix server
9. Happy developing!

### Developing Project

Everytime you wants to start developing, you have to run the postgres instance.

```sh
pg_ctl -o "-k /tmp" -l "$PGDATA/server.log" start
```

Don't forget to close the postgres socket when you finished  

```sh
pg_ctl -o "-k /tmp" -l "$PGDATA/server.log" stop
exit # to exit nix-shell
```

(c) 2022
