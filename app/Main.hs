module Main where

import Codec.Picture
import Codec.Picture.Gif
import Codec.Picture.Png
import Codec.Picture.Types
import Control.Parallel
import Control.Parallel.Strategies
import Data.Complex
import Data.List.Split
import System.Environment

main = do
  putStrLn "Resolution: "
  size <- read <$> getLine
  putStrLn "Iterations: "
  iters <- read <$> getLine
  putStrLn "Frame Delay: "
  delay <- read <$> getLine
  let gif =
        writeGifImages
          "out.gif"
          LoopingForever
          [ (greyPalette, delay, genFractal size iters comp)
          | comp <- [0,0.03 .. 2.2]
          ]
  either error id gif

genFractal size iters comp =
  generateImage (genPixel comp) size size :: Image Pixel8
  where
    genPixel c x y = div 0xff iters * (iters - boundedUntil c)
      where
        boundedUntil =
          isBounded iters $
          fromIntegral (x - div size 2) / (fromIntegral size / 3) :+
          fromIntegral (y - div size 2) / (fromIntegral size / 3)

isBounded iters c e = isBounded' 1 c
  where
    isBounded' i z
      | i == iters = i
      | magnitude z > e = i
      | otherwise = isBounded' (i + 1) $ z * z * z + c
