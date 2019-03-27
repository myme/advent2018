module Aoc2015.Day4.Day4 where

import           Crypto.Hash
import qualified Data.ByteString.Char8 as BS
import           Data.List

md5 :: BS.ByteString -> String
md5 = show . (hash :: BS.ByteString -> Digest MD5)

input :: BS.ByteString
input = "iwrupvqb"

md5list :: [(Int, String)]
md5list = map (\x -> (,) x (compute x)) ([1 ..] :: [Int])
  where compute = md5 . (input <>) . BS.pack . show

findMd5 :: Int -> Maybe Int
findMd5 n = fst <$> find (isPrefixOf (replicate n '0') . snd) md5list

part1 :: Maybe Int
part1 = findMd5 5

part2 :: Maybe Int
part2 = findMd5 6
