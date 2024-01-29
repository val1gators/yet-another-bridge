#!/bin/bash

#fee=24044002524012
fee=25000000000000
approve=$((124000000000000+${fee}))
amount=124000000000000

starkli invoke /
  $NATIVE_TOKEN_ETH_STARKNET approve $ESCROW_CONTRACT_ADDRESS u256:$approve /
  / $ESCROW_CONTRACT_ADDRESS set_order 0x70997970C51812dc3A010C7d01b50e0d17dc79C8 /
  u256:$amount u256:$fee --private-key $STARKNET_PRIVATE_KEY --account $STARKNET_ACCOUNT