// https://adventofcode.com/2020/day/5#part2
/*
--- Part Two ---

Ding! The "fasten seat belt" signs have turned on. Time to find your seat.

It's a completely full flight, so your seat should be the only missing boarding pass in your list. However, there's a catch: some of the seats at the very front and back of the plane don't exist on this aircraft, so they'll be missing from your list as well.

Your seat wasn't at the very front or back, though; the seats with IDs +1 and -1 from yours will be in your list.

What is the ID of your seat?

*/

import "io" for File

var highest = 0
var ids = []

File.read("./day/5/input.txt").trim().split("\n").each {|item|

  // Create all the posible rows
  // Select the row portions of the commands
  var rowCommands = item[0...7]
  var elements = (0..127).toList
  var half = 0

  rowCommands.each{|command|
    half = ((elements.count) / 2).floor
    // upper half
    if (command == "B") {
      elements = elements[half...elements.count]
    } else {
      // lower half
      elements = elements[0...half]
    }
  }

  // Save the row number
  var row = elements[0]

  // all possible cols
  elements = (0..8).toList
  var colCommands = item[7...item.count]

  colCommands.each{|command|
    half = ((elements.count) / 2).floor
    // upper half
    if (command == "R") {
      elements = elements[half...elements.count]
    } else {
      // lower half
      elements = elements[0...half]
    }
  }

  // Save the col number
  var col = elements[0]

  // ID
  var id = row * 8 + col

  if (id > highest) {
    highest = id
  }

  ids.add(id)
}

// Get all possible ids
// And consider only the ones not used
// Since our seat was not in the upper front or the lower back
// we start at the middle.
// Also we discard all the ids above the highest possible occupied seat
var id = 0
var myid = 0

for (row in (127 / 2).round..127) {
  for (col in 0..8) {
    id = row * 8 + col
    if (!ids.contains(id) && id < highest) {
      myid = id
      break
    }
  }
}

// 565
System.print(myid)
