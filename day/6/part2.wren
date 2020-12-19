// https://adventofcode.com/2020/day/6#part2
/*
--- Part Two ---

As you finish the last group's customs declaration, you notice that you misread one word in the instructions:

You don't need to identify the questions to which anyone answered "yes"; you need to identify the questions to which everyone answered "yes"!

Using the same example as above:

abc

a
b
c

ab
ac

a
a
a
a

b

This list represents answers from five groups:

    In the first group, everyone (all 1 person) answered "yes" to 3 questions: a, b, and c.
    In the second group, there is no question to which everyone answered "yes".
    In the third group, everyone answered yes to only 1 question, a. Since some people did not answer "yes" to b or c, they don't count.
    In the fourth group, everyone answered yes to only 1 question, a.
    In the fifth group, everyone (all 1 person) answered "yes" to 1 question, b.

In this example, the sum of these counts is 3 + 0 + 1 + 1 + 1 = 6.

For each group, count the number of questions to which everyone answered "yes". What is the sum of those counts?
*/

import "io" for File

var total = 0

File.read("./day/6/input.txt").trim().split("\n\n").each{|group|
  var counters = {}
  var people = group.split("\n")

  // Each letter should have at min the same amount of people in the group
  var minimumCount = people.count

  people.each{|person|
    person.each{|letter|
      // count each letter
      // init to zero if the value is null
      counters[letter] = counters[letter] || 0
      counters[letter] = counters[letter] + 1

      // If the letter reached the required count
      // then we add 1 to the total (because we found 1 letter which all said yes to)
      if (counters[letter] >= minimumCount) {
        total = total + 1
      }
    }
  }
}

// 3406
System.print(total)
