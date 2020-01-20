pragma solidity ^0.5.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/SupplyChain.sol";

contract TestSupplyChain {
    // Test for failing conditions in this contracts:
    // https://truffleframework.com/tutorials/testing-for-throws-in-solidity-tests

    SupplyChain supply_chain;

    function beforeEach() public {
      supply_chain = new SupplyChain();
      supply_chain.addItem("failure",10);
    }

    function testBuyItemNoFunds() public {
      (bool success, bytes memory data) = address(supply_chain).call.value(5)(abi.encodeWithSignature("buyItem(uint)", 0));
      Assert.equal(success, false, "Doesn't allow to sell if missing funds");
    }

    function testBuyItemWithFunds() public {
      (bool success, bytes memory data) = address(supply_chain).call.value(11)(abi.encodeWithSignature("buyItem(uint)", 0));
      Assert.equal(success, true, "Doesn't allow to sell if missing funds");
    }

    function testBuyItemNotForSale() public {
      (bool success, bytes memory data) = address(supply_chain).call.value(10)(abi.encodeWithSignature("buyItem(uint)", 1));
      Assert.equal(success, false, "Doesn't allow to sell iif item does not exists");
    }

    // test for purchasing an item that is not for Sale

    // shipItem

    // test for calls that are made by not the seller
    // test for trying to ship an item that is not marked Sold

    // receiveItem

    // test calling the function from an address that is not the buyer
    // test calling the function on an item not marked Shipped

}
