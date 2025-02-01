# References types are data types that are passed by their reference, pointer to where the actual data is stored

# pragma version ^0.4.0

struct Person:
    name: String[100]
    age: uint256

# fixed sized list
nums: public(uint256[10]) # must be bounded
myMap: public(HashMap[address, uint256])
person: public(Person)

@deploy
def __init__():
    # this updates self.nums[0]
    self.nums[0] = 123
    self.nums[9] = 456

    # copies self.nums to array in memory
    # does not modify referenced variable(self.nums)
    arr: uint256[10] = self.nums
    arr[0] = 123

    # this updates self.myMap
    self.myMap[msg.sender] = 1
    self.myMap[msg.sender] = 11

    # this updates self.person
    self.person.age = 11
    self.person.name = "Vyper"

    # Person struct is copied into memory
    # does not modify referenced variable(self.person)
    p: Person = self.person
    p.name = "Solidity"