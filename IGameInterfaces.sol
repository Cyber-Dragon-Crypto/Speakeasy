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
interface IGameInteractiveDashboard is IGameDashboard{
    function placeBet(address _bettor, uint256 amount) external;
}
