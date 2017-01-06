{-# LANGUAGE OverloadedStrings #-}

import TreeBuild
import HXML
import Control.Exception
import Control.Monad

import XmlLibrary

main = mainBenchmark hxmlLibrary

hxmlLibrary = XmlLibrary parse render where
  parse f = do
    tree <- parseXML <$> readFile f
    case tree of
      Tree _ nn -> do
        _ <- evaluate $ length nn
        return tree
  render f = writeFile f . showXML
