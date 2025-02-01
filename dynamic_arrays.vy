# Dynamic arrays are bounded arrays whose length can change. The length of the array cannot exceed the maximum length set where the array is declared.

# pragma version ^0.4.0

# Dynamic array of type uint256, max 3 elements
nums: public(DynArray[uint256, 3])

@deploy
def __init__():
    self.nums.append(11)
    self.nums.append(22)
    self.nums.append(33)

    # this will revert because there is only 3 elements we can add to it
    # self.nums.append(44)

    # remove last element
    self.nums.pop()

    # delete all element
    self.nums = []

    # set values
    self.nums = [1, 2, 3]

@external
@pure
def examples(xs: DynArray[uint256, 5]) -> DynArray[uint256, 8]:
    ys: DynArray[uint256, 5] = [1, 2, 3]
    # copy xs into ys
    for x: uint256 in xs:
        ys.append(x)
    return ys

@external
@pure
def filter(addrs: DynArray[address, 5]) -> DynArray[address, 5]:
    nonzeros: DynArray[address, 5] = []
    for addr: address in addrs:
        if addr != empty(address):
            nonzeros.append(addr)
    return nonzeros