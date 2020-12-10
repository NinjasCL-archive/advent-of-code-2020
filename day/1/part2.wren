// https://adventofcode.com/2020/day/1#part2
/*
--- Part Two ---

The Elves in accounting are thankful for your help; one of them even offers you a starfish coin they had left over from a past vacation. They offer you a second one if you can find three numbers in your expense report that meet the same criteria.

Using the above example again, the three entries that sum to 2020 are 979, 366, and 675. Multiplying them together produces the answer, 241861950.

In your expense report, what is the product of the three entries that sum to 2020?
*/

import "io" for File

var report = File.read("./day/1/input.txt").trim().split("\n").map{|item| Num.fromString(item) }

var result = 0
var needle = 2020

report.each {|first|
  report.each {|second|
   report.each{|third|
    if ((first + second + third) == needle) {
     result = first * second * third
    }
   }
  }
}

// answer: 128397680
System.print(result)
