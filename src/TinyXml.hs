
import Control.Exception
import Control.Monad
import Data.ByteString.Char8 as BS
import Text.Xml.Tiny as Tiny
import XmlLibrary

main = mainBenchmark tinyXmlLibrary

tinyXmlLibrary = XmlLibrary parse render where
  parse = BS.readFile >=> either throwIO return . Tiny.parse
  render fp xml = BS.writeFile fp (rerender xml)
