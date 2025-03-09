// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {Script, console2} from "lib/forge-std/src/Script.sol";
import {HelperConfig} from "./HelperConfig.s.sol";
import {VRFCoordinatorV2_5Mock} from
    "lib/chainlink-brownie-contracts/contracts/src/v0.8/vrf/mocks/VRFCoordinatorV2_5Mock.sol";

contract CreateSubscription is Script {
    function createSubscriptionUsingConfig() public returns (uint256, address) {
      HelperConfig helperConfig = new HelperConfig();
      address vrfCoordinator = helperConfig.getConfig().vrfCoordinator;
      (uint256 subId,) = createSubscription(vrfCoordinator);
      return(subId, vrfCoordinator);

    }

    function createSubscription(address vrfCoordinator) public returns(uint256, address) {
      console2.log("creating subscription on chain id:", block.chainid);
      vm.startBroadcast();  
        uint256 subId = VRFCoordinatorV2_5Mock(vrfCoordinator).createSubscription();
      vm.stopBroadcast();
      console2.log("your subscription id is:", subId);
      console2.log("please update the subscription Id in your HelperConfig.s.sol");
      return(subId, vrfCoordinator);

    }

    function run() external returns (uint256, address) {
        return createSubscriptionUsingConfig();
    }
}
