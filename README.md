# xml-benchmark [![Hackage version](https://img.shields.io/hackage/v/xml-benchmark.svg?label=Hackage)](https://hackage.haskell.org/package/xml-benchmark) [![Stackage version](https://www.stackage.org/package/xml-benchmark/badge/lts?label=Stackage)](https://www.stackage.org/package/xml-benchmark) [![Linux Build Status](https://img.shields.io/travis/pepeiborra/xml-benchmark.svg?label=Linux%20build)](https://travis-ci.org/pepeiborra/xml-benchmark) 

A benchmark suite for DOM style XML parsing libraries, written to measure the performance of the TinyXml library. 

Currently the following libraries are included in the benchmark:
* TinyXml
* Hexml
* Xml-conduit
* Hxml (the parser used by hxql)
* pugiXml

## USAGE

* To run the benchmarks locally, `cabal install` and then `cabal bench`.
* To extend with a new xml file, add the file (bzipped) to the xml folder.
* To extend with a new xml library: 
  1. create a new Bench* Executable cabal stanza by applying `mainBenchmark`.
  2. add a new entry in the `libraries` list of `Bench.hs` matching the name of the executable stanza.
  
## PROCEDURE

Benchmarking lazy libraries is notoriously difficult. This project tries to sidestep the issue by having a process-based approach; for every library we create an executable that supports the following operations:
1. Validation: parse a file and output `OK` if valid, otherwise exit with an error code.
2. Roundtrip: parse a file into a DOM tree, and then output a new XML file.

## RESULTS 

To be addedd soon.
