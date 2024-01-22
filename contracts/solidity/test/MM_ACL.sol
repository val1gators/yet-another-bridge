// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.21;

import "forge-std/Test.sol";
import "../src/YABTransfer.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

contract TransferTest is Test {
    address public deployer = address(0xB321099cf86D9BB913b891441B014c03a6CcFc54);
    address public marketMaker;

    YABTransfer public yab;
    ERC1967Proxy public proxy;
    YABTransfer public yab_caller;

    function setUp() public {
        vm.startPrank(deployer);

        address snMessagingAddress = 0xde29d060D45901Fb19ED6C6e959EB22d8626708e;
        uint256 snEscrowAddress = 0x0;
        uint256 snEscrowWithdrawSelector = 0x15511cc3694f64379908437d6d64458dc76d02482052bfb8a5b33a72c054c77;
        marketMaker = 0xda963fA72caC2A3aC01c642062fba3C099993D56;
        
        yab = new YABTransfer();
        proxy = new ERC1967Proxy(address(yab), "");
        yab_caller = YABTransfer(address(proxy));
        yab_caller.initialize(snMessagingAddress, snEscrowAddress, snEscrowWithdrawSelector, marketMaker);

        vm.stopPrank();
    }

    function test_getMMAddress_deployer() public {
        vm.prank(deployer);
        address MMaddress = yab_caller.getMMAddress();
        assertEq(MMaddress, marketMaker);
    }

    function test_getMMAddress_mm() public {
        vm.prank(marketMaker);
        address MMaddress = yab_caller.getMMAddress();
        assertEq(MMaddress, marketMaker);
    }

    function test_getMMAddress_mm_fail() public {
        vm.expectRevert("Only Owner or MM can call this function");
        yab_caller.getMMAddress();
    }

    function test_set_and_get_MMAddress_deployer() public {
        vm.startPrank(deployer);
        address alice = makeAddr("alice");
        yab_caller.setMMAddress(alice);
        assertEq(yab_caller.getMMAddress(), alice);
        vm.stopPrank();
    }

    function test_set_MMAddress_fail() public {
        address bob = makeAddr("bob");
        vm.expectRevert(); //setMMAddress is only callable by the owner
        yab_caller.setMMAddress(bob);
    }

    function test_get_owner() public {
        address ownerAddress = yab_caller.getOwner();
        assertEq(ownerAddress, deployer);
    }
}
