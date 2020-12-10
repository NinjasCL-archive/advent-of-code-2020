// https://adventofcode.com/2020/day/3#part2
/*
--- Part Two ---

Time to check the rest of the slopes - you need to minimize the probability of a sudden arboreal stop, after all.

Determine the number of trees you would encounter if, for each of the following slopes, you start at the top-left corner and traverse the map all the way to the bottom:

    Right 1, down 1.
    Right 3, down 1. (This is the slope you already checked.)
    Right 5, down 1.
    Right 7, down 1.
    Right 1, down 2.

In the above example, these slopes would find 2, 7, 3, 4, and 2 tree(s) respectively; multiplied together, these produce the answer 336.

What do you get if you multiply together the number of trees encountered on each of the listed slopes?

*/
import "io" for File

var forest = File.read("./day/3/input.txt").trim().split("\n")
var max = forest[0].count
var last = forest.count


var countTrees = Fn.new{|rowstep, colstep|

  var column = 0
  var trees = 0
  var row = 0

  while(row < last) {

    column = column % max

    if (forest[row][column] == "#") {
      trees = trees + 1
    }

    column = column + colstep
    row = row + rowstep
  }

  return trees
}

System.print(
  countTrees.call(1, 1) * countTrees.call(1, 3) * countTrees.call(1, 5) * countTrees.call(1, 7) * countTrees.call(2, 1)
)
