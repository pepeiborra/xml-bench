{-# LANGUAGE FlexibleContexts #-}
import Control.Exception
import Control.Monad
import Data.ByteString.Char8 as BS
import Data.ByteString.Lazy.Char8 as LBS
import Text.XML.Expat.Format
import Text.XML.Expat.Tree
import XmlLibrary

main = mainBenchmark hexpatLibrary

parseToBS :: Monad m => BS.ByteString -> m (UNode BS.ByteString)
parseToBS = either (fail.show) return . parse' defaultParseOptions

hexpatLibrary = XmlLibrary parse render where
  parse  fp = BS.readFile fp >>= parseToBS
  render fp = LBS.writeFile fp . format
