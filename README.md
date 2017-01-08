# xml-benchmark [![Linux Build Status](https://img.shields.io/travis/pepeiborra/xml-benchmark.svg?label=Linux%20build)](https://travis-ci.org/pepeiborra/xml-benchmark) 

A benchmark suite for DOM style XML parsing libraries, written to measure the performance of the TinyXml library. 

Currently the following libraries are included in the benchmark:
* TinyXml
* Hexml
* Xml-conduit
* Hxml (the parser used by hxql)
* pugiXml
* Hexpat
* HaXml

## USAGE

* To run the benchmarks locally, `cabal install` and then `cabal bench`.
* To extend with a new xml file, add the file (bzipped) to the xml folder.
* To extend with a new xml library: 
  1. create a new Bench* Executable cabal stanza by applying `mainBenchmark`.
  2. add a new entry in the `libraries` list of `Bench.hs` matching the name of the executable stanza.
  
## PROCEDURE

Benchmarking lazy libraries is notoriously difficult. This project tries to sidestep the issue by having a process-based approach; for every library we create an executable that supports the following operations:
1. Validation: parse a file and output `OK` if valid, otherwise exit with an error code.
2. Roundtrip: parse a file into a DOM tree, and then output a new XML document freshly constructed from the tree.

The benchmark suite uses Criterion to run each executable against every file in the xml folder, in Validation and Roundtrip mode.

## RESULTS 

CPU: Quad Core 2.7 GHz Intel "Core i5" I5-2500S (Sandy Bridge)
RAM: 12GB 
OS: Mac Os Sierra 10.12.2
Cabal packages:
 * TinyXml 0.1
 * Hexml 0.3.1
 * Xml-conduit 1.4.0.2
 * HaXml 1.25.3
 * pugiXml 0.3.3
 * hxml from HXQ 0.20.1
 * Hexpat 0.20.9
 
<img href="results."> 

PugiXml and Hexml are the fastest in the validation test, followed closely by TinyXml. In the rendering test pugiXml, which delegates the rendering to a C library as well as the parsing, is the fastest again, beating TinyXml and Hexml by an order of magnitude.
