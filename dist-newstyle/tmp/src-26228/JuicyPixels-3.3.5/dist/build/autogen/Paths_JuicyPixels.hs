{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -Wno-missing-safe-haskell-mode #-}
module Paths_JuicyPixels (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [3,3,5] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/james/.cabal/store/ghc-8.10.4/JuicyPixels-3.3.5-1cc9fb25c01dac8b6c371b5873b400a200324e7173db562efa6a03efeb912355/bin"
libdir     = "/home/james/.cabal/store/ghc-8.10.4/JuicyPixels-3.3.5-1cc9fb25c01dac8b6c371b5873b400a200324e7173db562efa6a03efeb912355/lib"
dynlibdir  = "/home/james/.cabal/store/ghc-8.10.4/JuicyPixels-3.3.5-1cc9fb25c01dac8b6c371b5873b400a200324e7173db562efa6a03efeb912355/lib"
datadir    = "/home/james/.cabal/store/ghc-8.10.4/JuicyPixels-3.3.5-1cc9fb25c01dac8b6c371b5873b400a200324e7173db562efa6a03efeb912355/share"
libexecdir = "/home/james/.cabal/store/ghc-8.10.4/JuicyPixels-3.3.5-1cc9fb25c01dac8b6c371b5873b400a200324e7173db562efa6a03efeb912355/libexec"
sysconfdir = "/home/james/.cabal/store/ghc-8.10.4/JuicyPixels-3.3.5-1cc9fb25c01dac8b6c371b5873b400a200324e7173db562efa6a03efeb912355/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "JuicyPixels_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "JuicyPixels_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "JuicyPixels_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "JuicyPixels_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "JuicyPixels_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "JuicyPixels_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
