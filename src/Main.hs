module Main where

import qualified Day1.Day1 as Day1
import qualified Day2.Day2 as Day2
import qualified Day3.Day3 as Day3
import qualified Day4.Day4 as Day4
import qualified Day5.Day5 as Day5
import qualified Day6.Day6 as Day6
import qualified Day7.Day7 as Day7
import qualified Day8.Day8 as Day8
import qualified Day9.Day9 as Day9
import qualified Day10.Day10 as Day10
import qualified Day11.Day11 as Day11
import qualified Day12.Day12 as Day12
import qualified Day13.Day13 as Day13
import qualified Day14.Day14 as Day14
import qualified Day15.Day15 as Day15

main :: IO ()
main = mapM_ printPuzzle $ zip ([1 ..] :: [Integer])
  [ Day1.puzzle
  , Day2.puzzle
  , Day3.puzzle
  , Day4.puzzle
  , Day5.puzzle
  , Day6.puzzle
  , Day7.puzzle
  , Day8.puzzle
  , Day9.puzzle
  , Day10.puzzle
  , Day11.puzzle
  , Day12.puzzle
  , Day13.puzzle
  , Day14.puzzle
  , Day15.puzzle
  ]
  where
    printPuzzle x = do
      putStrLn $ show (fst x) <> "."
      snd x
