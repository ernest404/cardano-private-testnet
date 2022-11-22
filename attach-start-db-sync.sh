# set session variable to the root directory of your cardano-db-sync project sources 
CARDANO_DB_SYNC_HOME=$HOME/src/cardano-db-sync

# navigate to top level folder of this project
cd $HOME/src/cardano-private-testnet-setup

# set the permissions of the postgres password file
chmod 0600 postgres-conn/pgpass-privatenet

# create a database named privatenet
PGPASSFILE=postgres-conn/pgpass-privatenet $CARDANO_DB_SYNC_HOME/scripts/postgresql-setup.sh --createdb              

# set the SCHEMA_DIR session variable to the schema folder from the cardano-db-sync project sources
export SCHEMA_DIR=$CARDANO_DB_SYNC_HOME/schema  

# run script file
cd $HOME/src/cardano-private-testnet-setup
./scripts/db-sync-start.sh  
# output
# verify the output does not show any errors
# in a steady state, you should see logs of SQL insert statements into slot_leader and block tables   

