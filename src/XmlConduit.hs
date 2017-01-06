
import Data.ByteString.Lazy.Char8 as BS
import Text.XML as XML
import Text.Blaze
import Text.Blaze.Renderer.Utf8
import XmlLibrary

main = mainBenchmark xmlConduitLibrary

xmlConduitLibrary = XmlLibrary parse render where
  parse  = XML.readFile def
  render destPath = BS.writeFile destPath . renderMarkup . toMarkup
