# Swap tokens on Curve

# pragma version ^0.4.0

from ethereum.ercs import IERC20

interface IStableSwap:
    def exchange(i: int128, j: int128, dx: uint256, min_dy: uint256): nonpayable

DAI: constant(address) = 0x6B175474E89094C44Da98b954EedeAC495271d0F
USDC: constant(address) = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48
USDT: constant(address) = 0xdAC17F958D2ee523a2206206994597C13D831ec7

POOL: constant(address) = 0xbEbc44782C7dB0a1A60Cb6fe97d0b483032FF1C7
COINS: constant(address[3]) = [DAI, USDC, USDT]

@internal
def _safe_transfer(coin: address, to: address, amount: uint256):
    res: Bytes[32] = raw_call(
        coin,
        concat(
            method_id("transfer(address,uint256)"),
            convert(to, bytes32),
            convert(amount, bytes32),
        ),
        max_outsize=32,
    )
    if len(res) > 0:
        assert convert(res, bool)

@internal
def _safe_transfer_from(coin: address, _from: address, to: address, amount: uint256):
    res: Bytes[32] = raw_call(
        coin,
        concat(
            method_id("transferFrom(address,address,uint256)"),
            convert(_from, bytes32),
            convert(to, bytes32),
            convert(amount, bytes32),
        ),
        max_outsize=32,
    )
    if len(res) > 0:
        assert convert(res, bool)

@internal
def _safe_approve(coin: address, to: address, amount: uint256):
    res: Bytes[32] = raw_call(
        coin,
        concat(
            method_id("approve(address,uint256)"),
            convert(to, bytes32),
            convert(amount, bytes32),
        ),
        max_outsize=32,
    )
    if len(res) > 0:
        assert convert(res, bool)

@external
def swap(i: int128, j: int128, dx: uint256, min_dy: uint256):
    self._safe_transfer_from(COINS[i], msg.sender, self, dx)
    self._safe_approve(COINS[i], POOL, dx)

    extcall IStableSwap(POOL).exchange(i, j, dx, min_dy)

    bal: uint256 = staticcall IERC20(COINS[j]).balanceOf(self)
    self._safe_transfer(COINS[j], msg.sender, bal)