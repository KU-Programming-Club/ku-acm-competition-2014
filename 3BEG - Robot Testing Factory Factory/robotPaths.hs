module Main where

import Control.Monad

data Robot = Robot {x :: Int ,
                    y :: Int ,
                    dir :: Int,
                    rotation :: Int } deriving (Show)
                                               
main :: IO () 
main = do
  tStr <- getLine
  let numTests = read tStr :: Int
  testStrs <- replicateM numTests getLine
  let results = [(run (Robot x y dir rot) t w h) | 
                  line <- map words testStrs, 
                  let [w, h, x, y, dir, rot, t] = map (\s -> read s::Int) line] 
  mapM_ (\(x, y) -> putStrLn (show x ++ " " ++ show y)) results

run :: Robot -> Int -> Int -> Int -> (Int, Int)
run (Robot x y _ _) 0 _ _ = (x,y)
run (Robot 0 0  _ _) _ 1 1 = (0,0)
run robot t w h = run (nextMove robot) (t-1) w h 
  where
    nextMove :: Robot -> Robot  
    nextMove r = 
      if checkMove w h $ move r
      then move r   
      else nextMove $ rotate r   
  
move :: Robot -> Robot
move (Robot x y dir rot) = 
  case dir of
    90  -> Robot x (y-1) dir rot
    270 -> Robot x (y+1) dir rot
    180 -> Robot (x-1) y dir rot
    0   -> Robot (x+1) y dir rot
    
rotate :: Robot ->  Robot
rotate (Robot x y dir rot) = Robot x y (fixDir $ dir+rot) rot where
  fixDir dir | dir >= 360 = dir - 360 
             | dir < 0   = dir + 360
             | otherwise = dir              

checkMove :: Int -> Int -> Robot -> Bool
checkMove w h (Robot x y _ _) = (x >= 0 && x < w) && (y >= 0 && y < h) 
