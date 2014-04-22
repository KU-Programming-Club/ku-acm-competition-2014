module Main where

import Data.Char

class Unit a where
	health :: a -> Int
	spawn :: a
	injure :: Int -> a
	offense :: a -> Int

newtype Archer = Archer { ah :: Int }
newtype Infantry = Infantry { ih :: Int } 
newtype Troll = Troll { th :: Int }
newtype Pikeman = Pikeman { ph :: Int }
newtype Swordsman = Swordsman { sh :: Int }
newtype Ballista = Ballista { bh :: Int }

instance Unit Archer where
	health = ah
	spawn = Archer 5
	injure = Archer
	offense _ = 10

instance Unit Infantry where
	health = ih
	spawn = Infantry 10
	injure = Infantry
	offense _ = 7

instance Unit Troll where
	health = th
	spawn = Troll 10
	injure = Troll
	offense _ = 15

instance Unit Pikeman where
	health = ph
	spawn = Pikeman 15
	injure = Pikeman
	offense _ = 5
	
instance Unit Swordsman where
	health = sh
	spawn = Swordsman 7
	injure = Swordsman
	offense _ = 7
	
instance Unit Ballista where
	health = bh
	spawn = Ballista 5
	injure = Ballista
	offense _ = 20
	
main :: IO ()
main = do
	pikemen <- extract
	swordsmen <- extract
	ballista <- extract
	archers <- extract
	infantry <- extract
	trolls <- extract
	battle archers infantry trolls pikemen swordsmen ballista 
	
extract :: Unit a => IO [a]
extract = do
	[n,unit] <- fmap words getLine
	return $ replicate (read n) $ if elem unit ["Pikemen", "Swordsmen", "Ballista", "Archers", "Infantry", "Trolls"] then spawn else error "wat"

data Either3 a b c = Left3 a | Middle3 b | Right3 c
	
weakest :: (Unit a, Unit b, Unit c) => [a] -> [b] -> [c] -> Maybe (Either3 a b c)
weakest [] [] [] = Nothing
weakest (a:_) [] [] = Just $ Left3 a
weakest [] (b:_) [] = Just $ Middle3 b
weakest [] [] (c:_) = Just $ Right3 c
weakest (a:_) (b:_) [] | health a < health b = Just $ Left3 a
					   | health a > health b = Just $ Middle3 b
					   | otherwise = if offense a > offense b then Just (Left3 a) else Just (Middle3 b)
weakest (a:_) [] (c:_) | health a < health c = Just $ Left3 a
					   | health a > health c = Just $ Right3 c
					   | otherwise = if offense a > offense c then Just (Left3 a) else Just (Right3 c)
weakest [] (b:_) (c:_) | health b < health c = Just $ Middle3 b
					   | health b > health c = Just $ Right3 c
					   | otherwise = if offense b > offense c then Just (Middle3 b) else Just (Right3 c)
weakest (a:_) (b:_) (c:_) | health a < health b && health a < health c = Just $ Left3 a
						  | health b < health a && health b < health c = Just $ Middle3 b
						  | health c < health a && health c < health b = Just $ Right3 c
						  | health a == health b && health a < health c = weakest [a] [b] []
						  | health a == health c && health a < health b = weakest [a] [] [c]
						  | health b == health c && health b < health a = weakest [] [b] [c]
						  | offense a > offense b && offense a > offense c = Just $ Left3 a
						  | offense b > offense a && offense b > offense c = Just $ Middle3 b
						  | offense c > offense a && offense c > offense b = Just $ Right3 c
						  | otherwise = error $ (show $ health a) ++ " " ++ (show $ health b) ++ " " ++ (show $ health c)

-- Gross, hard-coded algorithm
strongestGoblin :: [Archer] -> [Infantry] -> [Troll] -> Int
strongestGoblin _ _ (t:_) = offense t
strongestGoblin (a:_) _ _ = offense a
strongestGoblin _ (i:_) _ = offense i

-- Gross, hard-coded algorithm
strongestDwarf :: [Pikeman] -> [Swordsman] -> [Ballista] -> Int
strongestDwarf _ _ (b:_) = offense b
strongestDwarf _ (s:_) _ = offense s
strongestDwarf (p:_) _ _ = offense p

attack :: (Unit b, Unit c, Unit d) => Int -> [b] -> [c] -> [d] -> Maybe ([b], [c], [d])
attack _ [] [] [] = Nothing
attack 0 bs cs ds = Just (bs, cs, ds)
attack hurt bs cs ds = case weakest bs cs ds of
	Nothing -> Nothing
	Just (Left3 b) -> if hurt - (health b) > 0
					  then attack (hurt - (health b)) (tail bs) cs ds
					  else Just ((injure (health b - hurt)) : tail bs, cs, ds)
	Just (Middle3 c) -> if hurt - (health c) > 0
						then attack (hurt - (health c)) bs (tail cs) ds
						else Just (bs, (injure (health c - hurt)) : tail cs, ds)
	Just (Right3 d) -> if hurt - (health d) > 0
					   then attack (hurt - (health d)) bs cs (tail ds)
					   else Just (bs, cs, (injure (health d - hurt)) : tail ds)
	
battle :: [Archer] -> [Infantry] -> [Troll] -> [Pikeman] -> [Swordsman] -> [Ballista] -> IO ()
battle archers infantrys trolls pikemen swordsmen ballistas = do
	case attack (strongestGoblin archers infantrys trolls) pikemen swordsmen ballistas of
		Nothing -> putStrLn "Victory"
		Just (ps, ss, bs) -> do
			case attack (strongestDwarf ps ss bs) archers infantrys trolls of
				Nothing -> putStrLn "Defeat"
				Just (az, is, ts) -> battle az is ts ps ss bs