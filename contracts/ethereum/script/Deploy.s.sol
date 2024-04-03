// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {PaymentRegistry} from "../src/PaymentRegistry.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

contract Deploy is Script {
    function run() external returns (address, address) {
        uint256 deployerPrivateKey = vm.envUint("ETHEREUM_PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        address STARKNET_MESSAGING_ADDRESS = vm.envAddress("STARKNET_MESSAGING_ADDRESS");
        uint256 STARKNET_CLAIM_PAYMENT_SELECTOR = vm.envUint("STARKNET_CLAIM_PAYMENT_SELECTOR");
        uint256 snClaimPaymentBatchSelector = vm.envUint("STARKNET_CLAIM_PAYMENT_BATCH_SELECTOR"); //TODO add this in .env
        address MM_ETHEREUM_WALLET_ADDRESS = vm.envAddress("MM_ETHEREUM_WALLET_ADDRESS");
        address ZKSYNC_DIAMOND_PROXY_ADDRESS = vm.envAddress("ZKSYNC_DIAMOND_PROXY_ADDRESS");
        bytes4 ZKSYNC_CLAIM_PAYMENT_SELECTOR = bytes4(vm.envBytes("ZKSYNC_CLAIM_PAYMENT_SELECTOR"));

        PaymentRegistry yab = new PaymentRegistry();
        ERC1967Proxy proxy = new ERC1967Proxy(address(yab), "");
        PaymentRegistry(address(proxy)).initialize(
            STARKNET_MESSAGING_ADDRESS, 
            STARKNET_CLAIM_PAYMENT_SELECTOR, 
            snClaimPaymentBatchSelector, 
            MM_ETHEREUM_WALLET_ADDRESS,
            ZKSYNC_DIAMOND_PROXY_ADDRESS,
            ZKSYNC_CLAIM_PAYMENT_SELECTOR
        );

        vm.stopBroadcast();

        return (address(proxy), address(yab));
    }
}
