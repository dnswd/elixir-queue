with import <nixpkgs> { };

let
  # define packages to install
  basePackages = [
    git
    # replace with beam.packages.erlang.elixir_1_13 if you need
    beam.packages.erlang.elixir
    nodejs
    postgresql_14
    # only used for frontend dependencies
    # you are free to use yarn2nix as well
    nodePackages.node2nix
    # formatting js file
    nodePackages.prettier
  ];

  inputs = basePackages ++ lib.optionals stdenv.isLinux [ inotify-tools ]
    ++ lib.optionals stdenv.isDarwin
    (with darwin.apple_sdk.frameworks; [ CoreFoundation CoreServices ]);

  # define shell startup command
  hooks = ''
    # this allows mix to work on the local directory
    mkdir -p .nix-mix .nix-hex
    export MIX_HOME=$PWD/.nix-mix
    export HEX_HOME=$PWD/.nix-mix
    # make hex from Nixpkgs available
    # `mix local.hex` will install hex into MIX_HOME and should take precedence
    export MIX_PATH="${beam.packages.erlang.hex}/lib/erlang/lib/hex/ebin"
    export PATH=$MIX_HOME/bin:$HEX_HOME/bin:$PATH
    export LANG=C.UTF-8
    # keep your shell history in iex
    export ERL_AFLAGS="-kernel shell_history enabled"

    # postges related
    # keep all your db data in a folder inside the project
    export PGDATA="$PWD/db"

    # phoenix related env vars
    export POOL_SIZE=15
    export DB_URL="postgresql://postgres:postgres@localhost:5432/db"
    export PORT=4000
    export MIX_ENV=dev
    # add your project env vars here, word readable in the nix store.
    export ENV_VAR="your_env_var"
  '';

in mkShell {
  buildInputs = inputs;
  shellHook = hooks;
}

