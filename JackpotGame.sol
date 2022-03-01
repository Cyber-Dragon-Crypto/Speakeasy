// // SPDX-License-Identifier: MIT
pragma solidity >=0.8.11;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
interface IUniswapV2Router01 {
    function factory() external pure returns (address);
    function WETH() external pure returns (address);

    function addLiquidity(
        address tokenA,
        address tokenB,
        uint amountADesired,
        uint amountBDesired,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB, uint liquidity);
    function addLiquidityETH(
        address token,
        uint amountTokenDesired,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external payable returns (uint amountToken, uint amountETH, uint liquidity);
    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB);
    function removeLiquidityETH(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountToken, uint amountETH);
    function removeLiquidityWithPermit(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountA, uint amountB);
    function removeLiquidityETHWithPermit(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountToken, uint amountETH);
    function swapExactTokensForTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
    function swapTokensForExactTokens(
        uint amountOut,
        uint amountInMax,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
    function swapExactETHForTokens(uint amountOutMin, address[] calldata path, address to, uint deadline)
        external
        payable
        returns (uint[] memory amounts);
    function swapTokensForExactETH(uint amountOut, uint amountInMax, address[] calldata path, address to, uint deadline)
        external
        returns (uint[] memory amounts);
    function swapExactTokensForETH(uint amountIn, uint amountOutMin, address[] calldata path, address to, uint deadline)
        external
        returns (uint[] memory amounts);
    function swapETHForExactTokens(uint amountOut, address[] calldata path, address to, uint deadline)
        external
        payable
        returns (uint[] memory amounts);

    function quote(uint amountA, uint reserveA, uint reserveB) external pure returns (uint amountB);
    function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut) external pure returns (uint amountOut);
    function getAmountIn(uint amountOut, uint reserveIn, uint reserveOut) external pure returns (uint amountIn);
    function getAmountsOut(uint amountIn, address[] calldata path) external view returns (uint[] memory amounts);
    function getAmountsIn(uint amountOut, address[] calldata path) external view returns (uint[] memory amounts);
}



interface IUniswapV2Router02 is IUniswapV2Router01 {
    function removeLiquidityETHSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountETH);
    function removeLiquidityETHWithPermitSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountETH);

    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external payable;
    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
}
library SafeMath {
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");
        return c;
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }

    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }

    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");
        return c;
    }

    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }

    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b > 0, errorMessage);
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold
        return c;
    }
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }

    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}
// Interface for our Jackpot games
interface IGameBase {
    function isGameActive() external view returns (bool);
    function getCreditPrice() external view returns(uint256);
}
interface IGame is IGameBase {
    function placeBet(address _bettor, uint256 _toBet) external;

    function addtokenAmount(uint256 _tokens) external;

    function removeBet(address _bettor) external returns (uint256);

    function setCreditPrice(uint256 _amount) external;
}

interface IGameJob is IGameBase{
    function setSalty(uint256 _salty) external;
    function endGame() external;
    function startGame() external;
    function cleanGameHistory() external;
    function setGameHistory(uint256 _maxHistory) external;
}
interface IGameDashboard is IGameBase{
    function getTotalCredits() external view returns(uint256);
    function getTotalCreditsSoFar() external view returns(uint256);
    function getJackpotBNBPrice() external view returns(uint256);
    function getTotalSoFarBNBPrice() external view returns(uint256);
    function getBettingEnabled() external view returns(bool);
    function getTotalBettors() external view returns(uint256);
    function getBettorInfoByAddress(address _bettorAddress)
        external
        view
        returns (
            address _bettor,
            uint256 _credits,
            uint256 _betAmount,
            uint256 _tokenBalance);
    function getBettorInfoByIndex(uint256 _index)
        external
        view
        returns (
            address _bettor,
            uint256 _credits,
            uint256 _betAmount,
            uint256 _tokenBalance );
    function getSpinnyBetPercentage() external view returns(uint256);
    function getStartTime() external view returns(uint256);
    function getEndTime() external view returns(uint256);
    function getFreeToken() external view returns(uint256);

    // Events to let the front end know about changes
    event NewPlayerBet(
        address bettorAddress,
        uint256 betAmount,
        uint256 creditsGenerated,
        uint256 bettorsCount
    );
    event NewFreeToken(uint256 amount, address sender);
    event NewGameStarted(uint256 gameStartTime, uint256 gameEndTime);
    event WinnerAnnounced(
        address winnerAddress,
        uint256 winnerAmount,
        uint256 betAmount
    );
    event BetRemoved(address _bettor, uint256 _totalBettors);
}
contract JackpotGame is Ownable, ReentrancyGuard, IGame, IGameJob, IGameDashboard{
    using SafeMath for uint256;
    using SafeERC20 for IERC20;

    struct BettorInfo {
        uint256 totalBetAmount;
        uint256 credits;
        bool isBetted;
        uint256 betIndex;
    }

    struct WinnerInfo {
        address winner;
        uint256 winnerAmount;
        uint256 betAmount;
    }

    struct BettorInformation {
        address bettorAddress;
        uint256 credits;
        uint256 betAmount;
        uint256 tokenBalance;
    }
    IUniswapV2Router02 public uniswapV2Router;
    bool public bettingEnabled = true;

    // Timestamps for Game
    // Seconds since epoch
    // Using seconds since block.timestamp gives in same format
    uint256 private startTime;
    uint256 private endTime;

    uint256 public discountTime; // In seconds, like 3600 for an hour
    uint256 public discountPercentage = 1; // 50 for 50% of credit price

    uint256 public defaultGameDuration;
    uint256 nextGameDuration = 0;

    // Total Token = totalCredits * creditPrice
    uint256 private totalCredits;
    // Sum of all bets placed in this round
    uint256 private totalCreditsSoFar;
    // Price of single credit 0.01 BNB
    uint256 private creditPrice = 10000000000000000;

    uint256 private salty;

    uint256 public freeToken; // Tokens to be won
    uint256 private nextRoundToken; // Tokens to be forwarded to next round
    uint256 public totalBettors;
    uint256 public totalTokenWon; // Total Tokens won so far

    // Percentage of buyer's bet, spinny should get
    // this is the base value to which percentage resets after
    // other bettors' win
    uint256 private baseSpinnyBetPercentage;
    uint256 public spinnyBetPercentage;

    // Amount by which spinny percentage will decrease after each win
    uint256 public spinnyDecreaseFactor;

    uint256 public spinnyCredits;

    uint256 public gameId = 0;

    // Winner address
    address private winner;
    address public SPINNY;

    mapping(uint256 => mapping(address => bool)) private blacklist;
    mapping(uint256 => mapping(address => BettorInfo)) private _betMapping;
    mapping(uint256 => WinnerInfo) public previousWinner;
    //mapping(uint256 => address[]) public blacklistAddresses;
    mapping(uint256 => address[]) private _betted;

    IERC20 public TOKEN;

    address public jobOwner;

    uint256 private gameHistory = 2;
    // WinnerInfo public previousWinner;

    constructor(
        address token_,
        uint256 defaultGameDuration_ // 600(10 mins), 21600(6 hrs), 604800(A week for Jackpot) [All in seconds]
    ) {
        defaultGameDuration = defaultGameDuration_;

        SPINNY = address(this);
        spinnyBetPercentage = 100;
        baseSpinnyBetPercentage = 100;
        spinnyDecreaseFactor = 5;

        endTime = block.timestamp.add(defaultGameDuration);
        startTime = block.timestamp;

        TOKEN = IERC20(token_);
        salty = block.timestamp;

        uniswapV2Router = IUniswapV2Router02(0x9Ac64Cc6e4415144C455BD8E4837Fea55603e5c3);//IUniswapV2Router02(0x10ED43C718714eb63d5aA57B78B54704E256024E);
    }

    modifier gameProceed() {
        require(
            startTime <= block.timestamp && block.timestamp < endTime,
            "JackpotGame: seems like the game has already ended"
        );
        _;
    }

    modifier gameEnded() {
        require(
            (block.timestamp >= endTime),
            "JackpotGame: seems like the game has not ended yet"
        );
        _;
    }

    modifier onlyOwnerOrToken() {
        require(
            msg.sender == owner() || msg.sender == address(TOKEN),
            "JackpotGame: only owner or token can do this"
        );
        _;
    }

    modifier onlyOwnerOrJobOwner() {
        require(
            msg.sender == owner() || msg.sender == address(jobOwner),
            "JackpotGame: only owner or token can do this"
        );
        _;
    }

    modifier onlyToken() {
        require(
            msg.sender == address(TOKEN),
            "JackpotGame: only token can do this"
        );
        _;
    }

    function setSPINToken(address addr) external onlyOwner {
        require(TOKEN != IERC20(addr), "Token is already set");
        TOKEN = IERC20(addr);
    }

    function setJobOwner(address addr) external onlyOwner {
        require(jobOwner != addr, "Jobowner is already this address");
        jobOwner = addr;
    }

    function setDiscountTime(uint256 _time) external onlyOwner{
        discountTime = _time;   
    }

    function setDiscountPercent(uint256 _percent) external onlyOwner{
        discountPercentage = _percent;
    }

    function setGameHistory(uint256 _maxHistory) external onlyOewner{
        gameHistory = _maxHistory;
    }

    // TODO: Set credit price for next game or maybe add 'gameEnded'
    // Dropped above functionality, as credit price have to be changed
    // in between games as per token price
    function setCreditPrice(uint256 amount_) external onlyOwnerOrToken {
        require(amount_ > 0, "JackpotGame: Credit price too low");
        creditPrice = amount_;
    }

    function setNextGameDuration(uint256 duration) external onlyOwner {
        nextGameDuration = duration;
    }

    function setSalty(uint256 _salty) external onlyOwnerOrJobOwner {
        salty = _salty;
    }

    function setBaseSpinnyPercentage(uint256 _percentage) external onlyOwner {
        require(baseSpinnyBetPercentage != _percentage, "JackpotGame: cannot set same value");
        baseSpinnyBetPercentage = _percentage;
    }

    function getBettorInfoByAddress(address _bettorAddress)
        external
        view
        returns (
            address _bettor,
            uint256 _credits,
            uint256 _betAmount,
            uint256 _tokenBalance
        )
    {
        return _getBettorInfo(_bettorAddress, gameId);
    }

    function getBettorInfoByIndex(uint256 _index)
        external
        view
        returns (
            address _bettor,
            uint256 _credits,
            uint256 _betAmount,
            uint256 _tokenBalance
        )
    {
        return _getBettorInfo(_betted[gameId][_index], gameId);
    }

    function getAllBettors(uint256 _gameId)
        external
        view
        returns (BettorInformation[] memory)
    {
        BettorInformation[] memory _bettorInfo = new BettorInformation[](
            _betted[_gameId].length
        );
        
        for (uint256 i = 0; i < _betted[_gameId].length; i++) {
            (
                address bettorAddress,
                uint256 credits,
                uint256 betAmount,
                uint256 tokenBalance
            ) = _getBettorInfo(_betted[_gameId][i], _gameId);
            _bettorInfo[i].bettorAddress = bettorAddress;
            _bettorInfo[i].credits = credits;
            _bettorInfo[i].betAmount = betAmount;
            _bettorInfo[i].tokenBalance = tokenBalance;
        }
        return _bettorInfo;
    }


    function checkBlacklistAddress(address blacklistAddress)
        external
        view
        returns (bool)
    {
        if(blacklist[gameId][blacklistAddress])
            return true;
        else    
            return false;

    }

    function isGameActive() external view  returns (bool) {
        return block.timestamp < endTime;
    }

    // === Game functions ===

    function extendGame(uint256 endTime_) external onlyOwner gameProceed {
        require(endTime_ > endTime, "JackpotGame: invalid extend time");
        endTime = endTime_;
    }

    function endGameByOwner() external nonReentrant onlyOwner {
        // Only Owner can call this function
        _endGame();
    }

    function endGame() external nonReentrant gameEnded {
        // The game has not ended yet
        _endGame();
    }

    function startGame() external nonReentrant gameEnded {
        _startGameNow();
    }

    function cleanGameHistory() external nonReentrant onlyOwnerOrJobOwner {
        //delete all mappings
        require(gameId > gameHistory, "No history found");
        for(uint256 i = 0; i > (gameId-gameHistory); i++) {
            /*for(uint256 y = 0; y < blacklist[i]; y++) {
                delete blacklist[i][y];            
            }*/
            for (uint256 y = 0; y < _betted[i].length; y++) {
                delete blacklist[i][(_betted[i][y])];
                delete _betted[i][y];
            }
        }
    }

    function placeBet(address _bettor, uint256 amount)
        external
        onlyToken
        gameProceed
        nonReentrant
    {

        uint256 tempCreditPrice;
        if((block.timestamp - startTime) <= discountTime && discountPercentage > 0) {
            //tempCreditPrice = (creditPrice * discountPercentage) / 100;
            tempCreditPrice = (creditPrice.mul(discountPercentage)).div(100);
        } else {
            tempCreditPrice = creditPrice;
        }
        
        // require(
        //     msg.sender == address(SPIN_TOKEN),
        //     "JackpotGame: Please buy the SPIN token to place bet"
        // );
        require(
            bettingEnabled,
            "JackpotGame: Placing bets has been temporarily disabled!"
        );
        /*require(
            amount >= tempCreditPrice,
            "JackpotGame: Did not receive enough for a credit"
        );*/
        if(amount <= tempCreditPrice){
            return; 
        }
        
        if (!blacklist[gameId][_bettor]) {
            //uint256 amountCredits = amount - (amount % tempCreditPrice);
            uint256 amountCredits = amount.sub(amount.mod(tempCreditPrice));

            //uint256 _thisPlayerCredits = (amountCredits / tempCreditPrice) * 100;
            uint256 _thisPlayerCredits = (amountCredits.div(tempCreditPrice)).mul(100);

            if (_betMapping[gameId][_bettor].isBetted) {
                //_betMapping[gameId][_bettor].totalBetAmount += amount;
                //_betMapping[gameId][_bettor].credits += _thisPlayerCredits;
                _betMapping[gameId][_bettor].totalBetAmount = (_betMapping[gameId][_bettor].totalBetAmount).add(amount);
                _betMapping[gameId][_bettor].credits = (_betMapping[gameId][_bettor].credits).add(_thisPlayerCredits);
            } else {
                _betMapping[gameId][_bettor] = BettorInfo(
                    amount,
                    _thisPlayerCredits,
                    true,
                    _betted[gameId].length
                );
                _betted[gameId].push(_bettor);
                //totalBettors += 1;
                totalBettors = totalBettors.add(1);
            }

            uint256 _newSpinnyCredits = 0;
            if(spinnyBetPercentage > 0) {
                //_newSpinnyCredits = _thisPlayerCredits * (spinnyBetPercentage / 100);
                //spinnyCredits += _newSpinnyCredits;
                _newSpinnyCredits = _thisPlayerCredits.mul(spinnyBetPercentage.div(100));
                spinnyCredits = spinnyCredits.add(_newSpinnyCredits);
                require(spinnyCredits > 0, "why?");
            }

            //totalCredits += _thisPlayerCredits + _newSpinnyCredits;
            //totalCreditsSoFar += _thisPlayerCredits + _newSpinnyCredits;
            totalCredits = totalCredits.add(_thisPlayerCredits).add(_newSpinnyCredits);
            totalCreditsSoFar = totalCreditsSoFar.add(_thisPlayerCredits).add(_newSpinnyCredits);
            // for (uint256 i = 0; i < _thisPlayerCredits; i++) {
            //     _betCreditsList[gameId].push(_bettor);
            // }
            emit NewPlayerBet(
                _bettor,
                amount,
                _thisPlayerCredits / 100,
                totalBettors
            );
        }
    }

    function addtokenAmount(uint256 _tokenAmount) external onlyToken{
        if (block.timestamp >= endTime) {
            // Round has ended
            //nextRoundToken += _tokenAmount;
            nextRoundToken = nextRoundToken.add(_tokenAmount);
        } else {
            //freeToken += _tokenAmount;
            freeToken = freeToken.add(_tokenAmount.div(3));
            nextRoundToken = nextRoundToken.add(_tokenAmount.mul(2).div(3));
            emit NewFreeToken(freeToken, msg.sender);
        }
    }
    function removeBet(address _bettor) external
        onlyToken
        gameProceed
        nonReentrant returns (uint256) {
        
        uint256 creditsToReduce = _betMapping[gameId][_bettor].credits;
        if(creditsToReduce == 0)
            return 0;

        // Have to ensure that spinnyBetPercentage is same through out the game
        //uint256 _subtractedSpinnyCredits = creditsToReduce * (spinnyBetPercentage / 100);
        uint256 _subtractedSpinnyCredits = creditsToReduce.mul(spinnyBetPercentage.div(10**10));

        // Only if the address has betted
        if (_betMapping[gameId][_bettor].isBetted) {
            // Remove address from betted addresses
            //address _lastInBetted = _betted[gameId][_betted[gameId].length - 1];
            address _lastInBetted = _betted[gameId][(_betted[gameId].length).sub(1)];
            uint256 _bettorIndex = _betMapping[gameId][_bettor].betIndex;
            _betted[gameId][_bettorIndex] = _lastInBetted;
            _betted[gameId].pop();

            // Update _lastInBetted addresses' index after swap
            _betMapping[gameId][_lastInBetted].betIndex = _bettorIndex;

            // Delete bettor's information
            delete _betMapping[gameId][_bettor];

            // Update total number of credits
            //totalCredits -= (creditsToReduce + _subtractedSpinnyCredits);
            totalCredits = totalCredits.sub(creditsToReduce.add(_subtractedSpinnyCredits));

            // Update spinny's credits
            //spinnyCredits -= (_subtractedSpinnyCredits);
            spinnyCredits = spinnyCredits.sub(_subtractedSpinnyCredits);

            blacklist[gameId][_bettor] = true;
            //blacklistAddresses[gameId].push(_bettor);

            // Finally, reduce the count of bettors
            //totalBettors -= 1;
            totalBettors = totalBettors.sub(1);

            emit BetRemoved(_bettor, totalBettors);
        }

        return creditsToReduce;
        //return 0;
    }

    function enableBetting(bool enabled) external onlyOwner {
        bettingEnabled = enabled;
    }

    function withdrawBNB(uint256 _amount) external onlyOwner {
        (bool success, ) = address(msg.sender).call{
            value: _amount
        }("");
    }
    function withdrawSpeezy(uint256 _amount) public onlyOwner {
        IERC20 tokenContract = IERC20(TOKEN);
        tokenContract.transfer(msg.sender, _amount);
    }
    function withdrawToken(address _tokenContract, uint256 _amount) public onlyOwner {
        IERC20 tokenContract = IERC20(_tokenContract);
        tokenContract.transfer(msg.sender, _amount);
    }

    // === Privates ===

    function _endGame() private {
        if (_betted[gameId].length == 1) {
            winner = _betted[gameId][0];
        } else if (_betted[gameId].length > 1) {
            // if(blacklistAddresses[gameId].length > 0) {
            //     uint256 counter = 0;
            //     address[] memory creditAddresses = new address[](_betCreditsList[gameId].length);

            //     for ( uint256 j = 0; j < _betCreditsList[gameId].length; j++ ) {
            //         if (!blacklist[gameId][_betCreditsList[gameId][j]]) {
            //             creditAddresses[counter] = _betCreditsList[gameId][j];
            //             counter++;
            //         }
            //     }

            //     _setRandomWinner(creditAddresses, counter);

            // } else {
            // _setRandomWinner(
            //     _betCreditsList[gameId],
            //     _betCreditsList[gameId].length
            // );
            winner = _setRandomWinner();
            // }
            require(winner != address(0), "Winner was ZERO");
        }

        if(_betted[gameId].length == 0) {
            //freeToken += nextRoundToken;
            /*freeToken = freeToken.add(nextRoundToken);
            nextRoundToken = 0;*/

            spinnyBetPercentage = baseSpinnyBetPercentage;
        }
        else if(winner == SPINNY) {
            //freeToken += nextRoundToken;
            /*freeToken = freeToken.add(nextRoundToken);
            nextRoundToken = 0;*/

            if(spinnyBetPercentage > 0) {
                if(spinnyBetPercentage <= spinnyDecreaseFactor)
                    spinnyBetPercentage = 0;
                else
                    spinnyBetPercentage = spinnyBetPercentage.sub(spinnyDecreaseFactor);
                    //spinnyBetPercentage -= spinnyDecreaseFactor;
            }

            previousWinner[gameId] = WinnerInfo(
                SPINNY,
                0,
                0
            );
            emit WinnerAnnounced(
                SPINNY,
                0,
                0
            );
        } else {
            _awardWinner();

            // All the free BNBs were consumed
            freeToken = nextRoundToken.div(2);
            nextRoundToken = nextRoundToken.div(2);

            spinnyBetPercentage = baseSpinnyBetPercentage;
        }

        // Start new game after each game end
        _startGameNow();
    }

    function _extendGame(uint256 _endTime) private {
        startTime = block.timestamp;
        endTime = _endTime;
        emit NewGameStarted(block.timestamp, _endTime);
    }

    function _startGameNow() private {
        _setupNextGameDuration();

        //uint256 endTime_ = block.timestamp + defaultGameDuration;
        uint256 endTime_ = block.timestamp.add(defaultGameDuration);
        require(endTime_ > block.timestamp, "JackpotGame: invalid end time");

        startTime = block.timestamp;
        endTime = endTime_;
        totalCredits = 0;
        totalCreditsSoFar = 0;
        winner = address(0);
        // iterations = 0;
        gameId++;
        totalBettors = 0;

        spinnyCredits = 0;

        // if (blacklistAddresses[gameId].length > 0) {
        //     for (uint256 i = 0; i < blacklistAddresses[gameId].length; i++) {
        //         delete blacklist[gameId][blacklistAddresses[gameId][i]];
        //     }
        //     delete blacklistAddresses[gameId];
        // }

        // if (_betted[gameId].length > 0) {
        //     uint256 totalNumber = _betted[gameId].length;
        //     for (uint256 i = (totalNumber - 1); i >= 0; i--) {
        //         delete _betMapping[gameId][_betted[gameId][i]];
        //         _betted[gameId].pop();
        //         if (i == 0) {
        //             break;
        //         }
        //     }
        // }
        // delete _betCreditsList[gameId];

        emit NewGameStarted(startTime, endTime);
    }

    function _setupNextGameDuration() private {
        if (nextGameDuration > 0) {
            defaultGameDuration = nextGameDuration;
            nextGameDuration = 0;
        }
    }

    function _awardWinner() private {
        //totalTokenWon += nextRoundToken;
        totalTokenWon = totalTokenWon.add(freeToken);

        uint256 balance = IERC20(TOKEN).balanceOf(address(this));
        if(balance>freeToken)
            sendTokens(freeToken, winner);
        else
            sendTokens(balance, winner);

        freeToken = 0;

        previousWinner[gameId] = WinnerInfo(
            winner,
            balance,
            _betMapping[gameId][winner].totalBetAmount
        );
        emit WinnerAnnounced(
            winner,
            balance,
            _betMapping[gameId][winner].totalBetAmount
        );
    }

    function sendTokens(uint256 _amount, address _winner) public {
        require(_amount > 0, "Not allowed amount");
        IERC20 tokenContract = IERC20(TOKEN);
        tokenContract.transfer(address(_winner), _amount);
    }

    /// @notice Generate a random number between "from" and "to"
    /// @param from The lowest number of the interval
    /// @param to The biggest number of the interval
    /// @param _salty A random number generated off-chain
    function _getRandom(
        uint256 from,
        uint256 to,
        uint256 _salty
    ) private view returns (uint256) {
        uint256 seed = uint256(
            keccak256(
                abi.encodePacked(
                    block.timestamp +
                        block.difficulty +
                        ((
                            uint256(keccak256(abi.encodePacked(block.coinbase)))
                        ) / (block.timestamp)) +
                        block.gaslimit +
                        ((uint256(keccak256(abi.encodePacked(msg.sender)))) /
                            (block.timestamp)) +
                        block.number +
                        _salty
                )
            )
        );
        return ((seed % (to - from)) + from);
    }

    function _setRandomWinner() private view returns(address adr){
        uint256 winnerCredit = _getRandom(1, totalCredits, salty);
        if(winnerCredit <= spinnyCredits) {
            return SPINNY;
        }

        uint256 previousCredit = spinnyCredits;
        for(uint256 i = 0; i < _betted[gameId].length; i++) {
            //previousCredit += _betMapping[gameId][_betted[gameId][i]].credits;
            previousCredit = previousCredit.add(_betMapping[gameId][_betted[gameId][i]].credits);
            if(winnerCredit <= previousCredit) {
                return _betted[gameId][i];
            }
        }
    }

    function _getBettorInfo(address _bettorAddress, uint256 _gameId)
        private
        view
        returns (
            address,
            uint256,
            uint256,
            uint256
        )
    {
        uint256 _tokenBalance = TOKEN.balanceOf(_bettorAddress);
        BettorInfo memory bettorMap = _betMapping[_gameId][_bettorAddress];
        return (
            _bettorAddress,
            //bettorMap.isBetted ? bettorMap.credits / 100 : 0,
            bettorMap.isBetted ? (bettorMap.credits).div(100) : 0,
            bettorMap.isBetted ? bettorMap.totalBetAmount : 0,
            _tokenBalance
        );
    }

    function getBNBPrice(uint256 _amountTokens)
        private
        view
        returns (uint256)
    {
        address[] memory path = new address[](2);
        path[0] = uniswapV2Router.WETH();
        path[1] = address(TOKEN);

        try uniswapV2Router.getAmountsIn(_amountTokens, path) returns (
            uint256[] memory amountsIn
        ) {
            return amountsIn[0];
        } catch {
            return 0;
        }
    }
    function getJackpotBNBPrice() external view returns(uint256){
        if(freeToken>0)
            return getBNBPrice(freeToken);
        else
            return 0;
    }
    function getTotalSoFarBNBPrice() external view returns(uint256){
        if(totalCreditsSoFar>0)
            return getBNBPrice(totalCreditsSoFar.mul(creditPrice));
        else
            return 0;
    }
    function getTotalCredits() external view returns(uint256){
        return totalCredits;
    }
    function getTotalCreditsSoFar() external view returns(uint256){
        return totalCreditsSoFar;
    }
    function getCreditPrice() external view returns(uint256){
        return creditPrice;
    }
    function getBettingEnabled() external view returns(bool){
        return bettingEnabled;
    }
    function getTotalBettors() external view returns(uint256){
        return totalBettors;
    }
    function getSpinnyCredits() external view returns(uint256){
        return spinnyCredits;
    }
    function getSpinnyBetPercentage() external view returns(uint256){
        return spinnyBetPercentage;
    }
    function getStartTime() external view returns(uint256){
        return startTime;
    }
    function getEndTime() external view returns(uint256){
        return endTime;
    }
    function getFreeToken() external view returns(uint256){
        return freeToken;
    }
    function getGameHistory() external view returns(uint256){
        return gameHistory;
    }
}
