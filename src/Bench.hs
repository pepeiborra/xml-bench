import Control.Monad
import qualified Data.HashSet as HashSet
import Data.Monoid
import System.Directory
import System.Process (readProcess)
import System.FilePath
import Paths_xml_benchmark
import Text.Printf
import Criterion.Main

libraries = [ "Hexml", "Pugi", "TinyXml", "Hexpat", "Haxml", "XmlConduit", "hxml" ]

exclude (_, "Haxml", "large.xml") = True
exclude (_mode, _lib, _file) = False

main = do
  binDir  <- getBinDir
  allBenchFiles <- HashSet.fromList <$> listDirectory "xml"
  forM_ allBenchFiles $ \f ->
    when (takeExtension f == ".bz2") $
      unless (dropExtension f `HashSet.member` allBenchFiles) $
        void $ readProcess "bunzip2" ["-fk", "xml" </> f] ""
  xmlFiles <- filter(\f -> takeExtension f == ".xml") <$> listDirectory "xml"
  printf "Reading from the xml folder: %s\n" (show xmlFiles)
  printf "Running benchmark binaries from %s\n" binDir

  let invokeWith args lib =
        void $ readProcess (binDir </> "Bench" <> lib) args ""

  let makeBenchmarkGroup name fp args =
        bgroup (name <> " - " <> fp)
        [ bench lib $ whnfIO $ invokeWith (("xml" </> fp) : args) lib
        | lib <- libraries
        , not $ exclude(name, lib, fp)]

  let benchmarks =
        [ makeBenchmarkGroup name fp args
          | (name, args) <- [ ("validate", []), ("render", ["--reprint"]) ]
          , fp <- xmlFiles
          ]

  defaultMain benchmarks
