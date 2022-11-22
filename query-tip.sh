#!/bin/bash
export CARDANO_NODE_SOCKET_PATH=private-testnet/node-bft1/node.sock
cardano-cli query tip --testnet-magic 42

