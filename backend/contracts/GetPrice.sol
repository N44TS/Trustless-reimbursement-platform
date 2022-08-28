// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "@openzeppelin/contracts/utils/math/SafeCast.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract Refund {
    using SafeCast for int256;
    using SafeMath for uint256;

    AggregatorV3Interface internal ethUsdPriceFeed;

    /**
     * Network: Goerli - different address required for different netwrosk, make sure to change! 
       https://docs.chain.link/docs/ethereum-addresses/
     */
    constructor() payable {
        ethUsdPriceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
    }

    //converts usd to eth but wrong by some decimal places atm
    function convertEthUsd(uint _amountInUsd) public view returns (uint) {
        uint EthUsd = getEthUsd();
        return _amountInUsd.mul(10 ** 18).div(EthUsd);
    }

        // shows the current price of eth/usd
        function getEthUsd() public view returns (uint) {
        (, int price, , , ) = ethUsdPriceFeed.latestRoundData();
        return price.toUint256();
    }

}
