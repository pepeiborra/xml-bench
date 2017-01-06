{-# LANGUAGE OverloadedStrings #-}

import Text.XML.Hexml as Hexml
import Control.Exception
import Control.Monad
import qualified Data.ByteString.Char8 as BS
import Data.Char
import Data.Monoid

import XmlLibrary

main = mainBenchmark hexmlLibrary

hexmlLibrary = XmlLibrary parse render where
  parse = BS.readFile >=> either (fail . BS.unpack) return . Hexml.parse
  render fp = BS.writeFile fp . rerender

rerender :: Node -> BS.ByteString
rerender = inside
    where
        inside x = BS.concat $ map (either validStr node) $ contents x
        node x = "<" <> BS.unwords (validName (name x) : map attr (attributes x)) <> ">" <>
                 inside x <>
                 "</" <> name x <> ">"
        attr (Attribute a b) = validName a <> "=\"" <> validAttr b <> "\""

        validName x | BS.all (\x -> isAlphaNum x || x `elem` ("-:_" :: String)) x = x
                    | otherwise = error "Invalid name"
        validAttr x | BS.notElem '\"' x = x
                    | otherwise = error "Invalid attribute"
        validStr x | BS.notElem '<' x || BS.isInfixOf "<!--" x = x
                   | otherwise = error $ show ("Invalid string", x)
