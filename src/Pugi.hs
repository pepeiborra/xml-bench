
import Control.Exception
import Control.Monad
import Data.ByteString.Lazy.Char8 as BS
import Text.XML.Pugi
import XmlLibrary

main = mainBenchmark pugiLibrary

pugiLibrary = XmlLibrary parse render where
  parse     = parseFile def
  render fp = BS.writeFile fp . pretty def
