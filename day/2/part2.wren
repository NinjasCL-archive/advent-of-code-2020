// https://adventofcode.com/2020/day/2#part2
/*
--- Part Two ---

While it appears you validated the passwords correctly, they don't seem to be what the Official Toboggan Corporate Authentication System is expecting.

The shopkeeper suddenly realizes that he just accidentally explained the password policy rules from his old job at the sled rental place down the street! The Official Toboggan Corporate Policy actually works a little differently.

Each policy actually describes two positions in the password, where 1 means the first character, 2 means the second character, and so on. (Be careful; Toboggan Corporate Policies have no concept of "index zero"!) Exactly one of these positions must contain the given letter. Other occurrences of the letter are irrelevant for the purposes of policy enforcement.

Given the same example list from above:

    1-3 a: abcde is valid: position 1 contains a and position 3 does not.
    1-3 b: cdefg is invalid: neither position 1 nor position 3 contains b.
    2-9 c: ccccccccc is invalid: both position 2 and position 9 contain c.

How many passwords are valid according to the new interpretation of the policies?
ds are valid according to their policies?
*/

import "io" for File

class Password {

  lower {_lower}
  upper {_upper}
  letter {_letter}
  password {_password}

  construct new(string) {

    var parts = string.split(" ")
    var bounds = parts[0]
    var dash = bounds.indexOf("-")

    _upper = Num.fromString(bounds[dash + 1...bounds.count])
    _lower = Num.fromString(bounds[0...dash])

    _letter = parts[1].trim(" :")
    _password = parts[2]
  }

  isValid() {
    var counter = 0

    if (password[lower - 1] == letter) {
      counter = counter + 1
    }

    if (password[upper - 1] == letter) {
      counter = counter + 1
    }

    return counter == 1
  }

  static isValid(string) {Password.new(string).isValid()}
}

var result = 0
File.read("./day/2/input.txt").trim().split("\n").each{|item|
  if (Password.isValid(item)) {
    result = result + 1
  }
}

// answer: 275
System.print(result)
