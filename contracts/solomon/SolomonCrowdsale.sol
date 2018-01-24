pragma solidity ^0.4.18;

import "zeppelin-solidity/contracts/math/SafeMath.sol";
import "zeppelin-solidity/contracts/crowdsale/CappedCrowdsale.sol";
import "zeppelin-solidity/contracts/crowdsale/RefundableCrowdsale.sol";
import "zeppelin-solidity/contracts/token/MintableToken.sol";

/**
 * @title SolomonCrowdsaleToken
 */
contract SolomonCrowdsaleToken is MintableToken {
  string public constant name = "Solomon Coin"; // solium-disable-line uppercase
  string public constant symbol = "SLMN"; // solium-disable-line uppercase
  uint8 public constant decimals = 18; // solium-disable-line uppercase
}


/**
 * @title SolomonCrowdsale
 */
contract SolomonCrowdsale is CappedCrowdsale, RefundableCrowdsale {
  uint32 public extraTokensPercents;

  function SolomonCrowdsale(uint256 _startTime, uint256 _endTime, uint256 _rate, uint256 _goal, uint256 _cap, address _wallet, uint32 _extraTokensPercents) public
    CappedCrowdsale(_cap)
    FinalizableCrowdsale()
    RefundableCrowdsale(_goal)
    Crowdsale(_startTime, _endTime, _rate, _wallet)
  {
    //As goal needs to be met for a successful crowdsale
    //the value needs to less or equal than a cap which is limit for accepted funds
    require(_goal <= _cap);
    extraTokensPercents = _extraTokensPercents;
  }

  function createTokenContract() internal returns (MintableToken) {
    return new SolomonCrowdsaleToken();
  }

  /**
   * @dev Mint extra tokens for team/advisors/bounty.
   */
  function finalization() internal {
    super.finalization();

    uint256 extraTokens = SafeMath.mul(token.totalSupply(), extraTokensPercents).div(100 - extraTokensPercents);
    token.mint(wallet, extraTokens);
  }
}
