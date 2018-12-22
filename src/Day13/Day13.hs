module Day13.Day13 where

import           Control.Monad.RWS
import           Data.Either
import           Data.Function
import           Data.List
import qualified Data.Map.Strict as M
import           Data.Tuple (swap)
import           Utils

type Coord = (Int, Int)
data Direction = L | U | R | D deriving (Enum, Show)
data Cart = Cart { _coord :: Coord
                 , _dir :: Direction
                 , _nextTurn :: Direction
                 } deriving Show
type Railway = M.Map Coord Char
type RailwayT = RWS Railway () ([Cart], [Cart])

turnChars :: String
turnChars = "/\\+"

parseDir :: Char -> Maybe Direction
parseDir '<' = Just L
parseDir '>' = Just R
parseDir '^' = Just U
parseDir 'v' = Just D
parseDir _ = Nothing

initState :: [String] -> ([Cart], Railway)
initState ls = let
  (carts, turns) = partition isLeft $ do
    (y, l) <- zip [0 ..] ls
    (x, c) <- zip [0 ..] l
    let coord = (x, y)
    if c `elem` turnChars
      then [Right (coord, c)]
      else case parseDir c of
             Nothing -> []
             Just dir -> [Left $ Cart coord dir L]
  in (lefts carts, M.fromList $ rights turns)

stepCart :: Cart -> RailwayT Cart
stepCart (Cart (x, y) dir turn) = do
  railway <- ask
  let coord' = case dir of
        L -> (x - 1, y)
        R -> (x + 1, y)
        U -> (x, y - 1)
        D -> (x, y + 1)
  (dir', turn') <- case M.lookup coord' railway of
    Nothing -> return (dir, turn)
    Just '/' -> return $ case dir of
      L -> (D, turn)
      R -> (U, turn)
      U -> (R, turn)
      D -> (L, turn)
    Just '\\' -> return $ case dir of
      L -> (U, turn)
      R -> (D, turn)
      U -> (L, turn)
      D -> (R, turn)
    Just '+' -> return $ case turn of
      L -> let d = case dir of
                 L -> D; R -> U; U -> L; D -> R
           in (d, U)
      R -> let d = case dir of
                 L -> U; R -> D; U -> R; D -> L
           in (d, L)
      U -> (dir, R)
      D -> error "Wrong turn type"
    _ -> error "Invalid char"
  return $ Cart coord' dir' turn'

stepUntilCrash :: RailwayT Coord
stepUntilCrash = do
  (carts, moved) <- get
  case carts of
    [] -> do
      let carts' = sortBy (compare `on` (swap . _coord)) moved
      put (carts', [])
      stepUntilCrash
    (c:cs) -> do
      c'@(Cart coord _ _) <- stepCart c
      put (cs, c':moved)
      if any ((== coord) . _coord) $ cs <> moved
        then return coord
        else stepUntilCrash

stepUntilOneLeft :: RailwayT Coord
stepUntilOneLeft = do
  remaining <- gets (uncurry (<>))
  case remaining of
    [] -> error "All gone!"
    [x] -> do
      x' <- stepCart x
      return (_coord x')
    _ -> do
      crash <- stepUntilCrash
      (carts, moved) <- get
      let carts' = filter ((/= crash) . _coord) carts
          moved' = filter ((/= crash) . _coord) moved
      put (carts', moved')
      stepUntilOneLeft

puzzle :: IO ()
puzzle = do
  (carts, railway) <- initState <$> readLines "./src/Day13/input.txt"
  let (part1, _) = evalRWS stepUntilCrash railway (carts, [])
  expect "part 1: " (50, 54) part1
  let (part2, _) = evalRWS stepUntilOneLeft railway (carts, [])
  expect "part 2: " (50, 100) part2
