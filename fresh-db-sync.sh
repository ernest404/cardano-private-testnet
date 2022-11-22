CARDANO_DB_SYNC_HOME=$HOME/src/cardano-db-sync

cd $HOME/plutus/snapbrillia/quadraticvoting/cardano-private-testnet-setup
PGPASSFILE=postgres-conn/pgpass-privatenet $CARDANO_DB_SYNC_HOME/scripts/postgresql-setup.sh --dropdb

