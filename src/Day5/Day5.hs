module Day5.Day5 where

import Data.Char (isAlpha, isUpper, isLower, toLower)
import Utils

data Zipper = Z String String

willReact :: Char -> Char -> Bool
willReact a b = (isUpper a && isLower b && toLower a == b) ||
                (isLower a && isUpper b && a == toLower b)

react :: String -> String
react = go . Z ""
  where go (Z prev "") = reverse prev
        go (Z "" (n:next)) = go $ Z [n] next
        go (Z (p:prev) (n:next)) | willReact p n = go $ Z prev next
                                 | otherwise = go $ Z (n:p:prev) next

puzzle :: IO ()
puzzle = do
  input <- filter isAlpha <$> readFile "./src/Day5/input.txt"

  let part1 = length $ react input
  expect "part 1: " 9238 part1

  let part2 = "not implemented"
  expect "part 2: " "" part2
