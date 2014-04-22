module Main where

contrlCost :: Int
contrlCost = 30

tapCost :: Int
tapCost = 15

defPorts :: Int
defPorts = 4

main :: IO ()
main = do
    n <- getLine
    let times = read n :: Int
    mainHelper times
    
mainHelper :: Int -> IO ()
mainHelper times = case times of
    0 -> return ()
    t -> do
        line <- getLine
        let info = map (read :: String -> Integer) $ words line
        case info of
             [n,m] -> do
                 putStrLn $ show $ cost n m
                 mainHelper $ t-1

cost :: Integer -> Integer -> Integer
cost n m = (max 0 $ n-m)*fromIntegral contrlCost + 15*(max 0 $ ceiling $ fromRational (fromIntegral (n-fromIntegral defPorts))/2)