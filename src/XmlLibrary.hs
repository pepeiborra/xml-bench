
{-# LANGUAGE NamedFieldPuns    #-}
{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE DeriveAnyClass    #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeOperators     #-}
{-# LANGUAGE ViewPatterns      #-}
{-# LANGUAGE ExistentialQuantification #-}

module XmlLibrary where

import Control.Exception
import Control.Monad
import Options.Generic
import System.Directory
import System.Exit
import System.FilePath
import System.IO

data XmlLibrary =
  forall xml . XmlLibrary { parse  :: FilePath -> IO xml,
                            render :: FilePath -> xml -> IO ()
                          }
data Options =
  Options { reprint :: Bool <?> "Reprint the XML document" }
  deriving (Generic, Show, ParseRecord)

data Args = Args Options [String] deriving (Generic, Show)

instance ParseRecord Args where parseRecord = Args <$> parseRecord <*> parseRecord

mainBenchmark(XmlLibrary parse render) = do
  Args Options{reprint = (unHelpful -> reprint)} paths <- getRecord "Validate XML"
  hSetBuffering stdout LineBuffering
  forM_ paths $ \p -> do
    res <- try $ parse p
    case res of
      Left (e::SomeException) -> do
        print e
        exitFailure
      Right node -> do
        putStrLn "OK"
        when reprint $ do
          let destPath = p <.> "reprint"
          existsAlready <- doesFileExist destPath
          if existsAlready
            then putStrLn $ "Overwriting " ++ destPath
            else putStrLn $ "Reprinting to " ++ destPath
          render destPath node
