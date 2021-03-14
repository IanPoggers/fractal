module Main where

import Codec.Picture
import Codec.Picture.Gif
import Codec.Picture.Png
import Codec.Picture.Types
import Control.Parallel
import Control.Parallel.Strategies
import Data.Complex
import Data.List.Split
import Data.Vector.Storable
import System.Environment

main = do
  putStrLn "Resolution: "
  size <- read <$> getLine
  putStrLn "Iterations: "
  iters <- read <$> getLine
  writePng "out.png" $ genFractal size iters 2

genFractal :: Int -> Int -> Complex Double -> Image Pixel8
genFractal size iters comp = Image size size $ fromList pixels
  where
    pixels =
      [genPixel comp (i `mod` size) (i `div` size) | i <- [0 .. size * size `div` 2]] `using`
      parList rdeepseq :: [Pixel8]
    genPixel comp x y =
      fromIntegral $ div 0xff iters * (iters - boundedUntil comp) :: Pixel8
      where
        boundedUntil =
          isBounded iters $
          fromIntegral (x - div size 2) / (fromIntegral size / 3) :+
          fromIntegral (y - div size 2) / (fromIntegral size / 3)

isBounded iters c comp = isBounded' 1 c
  where
    isBounded' i z
      | i == iters = i
      | magnitude z > 2 = i
      | otherwise = isBounded' (i + 1) $ (z ** comp) + c
