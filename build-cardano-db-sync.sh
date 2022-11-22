# update/upgrade your package indexes
sudo apt-get update
sudo apt-get upgrade  
# reboot as necessary
sudo apt-get install automake build-essential pkg-config libffi-dev libgmp-dev libssl-dev libtinfo-dev libsystemd-dev zlib1g-dev make g++ tmux git jq wget libncursesw5 libtool autoconf -y  

# download and run get-ghcup script
curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
# During questions, I chose to (A)ppend the path to ghc to .bashrc
# and did not choose to install Haskell Language Server (HLS) or stack
# source the bash start script to apply updates to PATH
cd $HOME
source .bashrc

# get the latest updates to GHCUp tool
ghcup upgrade

# install cabal with GHCUp 
ghcup install cabal 3.6.2.0
ghcup set cabal 3.6.2.0

# install GHC with GHCUp
ghcup install ghc 8.10.7
ghcup set ghc 8.10.7

# Update cabal and verify the correct versions were installed successfully.
cabal update

# Clone the secp256k1 source
cd $HOME/src
git clone https://github.com/input-output-hk/libsodium

# change directory
cd libsodium

# checkout specific branch    
git checkout 66f017f1

# apply configuration scripts and make project
./autogen.sh
./configure
make
sudo make install

# Clone the secp256k1 source
cd $HOME/src
git clone https://github.com/bitcoin-core/secp256k1.git secp256k1

# change directory
cd secp256k1

# reset the branch to appropriate commit    
git reset --hard ac83be33d0956faf6b7f61a60ab524ef7d6a473a

# apply configuration scripts and make project
./autogen.sh
./configure --prefix=/usr --enable-module-schnorrsig --enable-experimental
make
make check

# install library
sudo make install

cd $HOME/src
git clone https://github.com/input-output-hk/cardano-db-sync
cd cardano-db-sync  
# fetch the list of tags and check out the latest release tag name  
git fetch --tags --all

# checkout the latest release (currently 13.0.4 as of 8/22/22) of db-sync
git checkout $(curl -s https://api.github.com/repos/input-output-hk/cardano-db-sync/releases/latest | jq -r .tag_name)

sudo apt-get install libpq-dev
cabal update

# build cardano-db-sync executables
cabal build all

cp -p $(find dist-newstyle/build -type f -name "cardano-db-sync") $HOME/.local/bin/cardano-db-sync  

cardano-db-sync --version
# when this document was written, the current version for each is 13.0.4 on linux-x86_64