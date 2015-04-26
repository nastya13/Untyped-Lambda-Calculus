module Paths_typed_Lambda_Calculus (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch


version :: Version
version = Version {versionBranch = [0,1,0,0], versionTags = []}
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/anastasia/Haskell/typed-Lambda-Calculus/.cabal-sandbox/bin"
libdir     = "/home/anastasia/Haskell/typed-Lambda-Calculus/.cabal-sandbox/lib/x86_64-linux-ghc-7.8.3/typed-Lambda-Calculus-0.1.0.0"
datadir    = "/home/anastasia/Haskell/typed-Lambda-Calculus/.cabal-sandbox/share/x86_64-linux-ghc-7.8.3/typed-Lambda-Calculus-0.1.0.0"
libexecdir = "/home/anastasia/Haskell/typed-Lambda-Calculus/.cabal-sandbox/libexec"
sysconfdir = "/home/anastasia/Haskell/typed-Lambda-Calculus/.cabal-sandbox/etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "typed_Lambda_Calculus_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "typed_Lambda_Calculus_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "typed_Lambda_Calculus_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "typed_Lambda_Calculus_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "typed_Lambda_Calculus_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
