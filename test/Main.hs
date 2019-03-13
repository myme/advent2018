module Main where

import qualified Aoc2018.Day1.Day1 as Day1
import qualified Aoc2018.Day10.Day10 as Day10
import qualified Aoc2018.Day11.Day11 as Day11
import qualified Aoc2018.Day12.Day12 as Day12
import qualified Aoc2018.Day13.Day13 as Day13
import qualified Aoc2018.Day14.Day14 as Day14
import qualified Aoc2018.Day15.Day15 as Day15
import qualified Aoc2018.Day2.Day2 as Day2
import qualified Aoc2018.Day3.Day3 as Day3
import qualified Aoc2018.Day4.Day4 as Day4
import qualified Aoc2018.Day5.Day5 as Day5
import qualified Aoc2018.Day6.Day6 as Day6
import qualified Aoc2018.Day7.Day7 as Day7
import qualified Aoc2018.Day8.Day8 as Day8
import qualified Aoc2018.Day9.Day9 as Day9
import           Test.Hspec

main :: IO ()
main = hspec $ do
  describe "Advent of Code 2018" $ do
    describe "day1" $ do
      it "solves part 1" $ do
        part1 <- Day1.part1
        part1 `shouldBe` 531

      it "solves part 2" $ do
        part2 <- Day1.part2
        part2 `shouldBe` 76787

    it "solves day 2"  Day2.puzzle
    it "solves day 3"  Day3.puzzle
    it "solves day 4"  Day4.puzzle
    it "solves day 5"  Day5.puzzle
    it "solves day 6"  Day6.puzzle
    it "solves day 7"  Day7.puzzle
    it "solves day 8"  Day8.puzzle
    it "solves day 9"  Day9.puzzle
    it "solves day 10" Day10.puzzle
    it "solves day 11" Day11.puzzle
    it "solves day 12" Day12.puzzle
    it "solves day 13" Day13.puzzle
    it "solves day 14" Day14.puzzle
    xit "solves day 15" Day15.puzzle
