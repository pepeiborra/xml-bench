

import Control.Exception
import Control.Monad
import qualified Data.ByteString.Lazy as BS
import Text.XML.HaXml.ByteStringPP
import Text.XML.HaXml.Parse (xmlParse')
import XmlLibrary

main = mainBenchmark haXmlLibrary

haXmlLibrary = XmlLibrary parse render where
  parse  fp = readFile fp >>= either fail return . xmlParse' fp
  render fp = BS.writeFile fp . document
