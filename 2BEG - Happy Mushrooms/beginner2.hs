module Main where

import Control.Monad

main :: IO ()
main = do
  nStr <- getLine
  let n = read nStr :: Int
  replicateM n runTests
  return ()
  

runTests :: IO ()
runTests = do
  line <- getLine
  let [w,h] = map read $ words line
  farm <- replicateM h getLine
  putStrLn $ show $ sum [checkShroom y x w h farm |
                         y <- [0..h-1],
                         x <- [0..w-1]]
  
checkShroom :: Int -> Int ->  Int -> Int -> [String] -> Int
checkShroom y x w h strs =
  if c == '#'
  then 0   
  else if (y == 0 || x == 0) || (y == h-1 || x == w-1)     
       then 1   
       else if all (=='#') neighbors     
            then 0   
            else 1     
  where
    c = strs !! y !! x 
    neighbors = map (\(x',y') -> strs !! (y+y') !! (x+x')) [(0,1), (0,-1), (1,0), (-1,0)] 