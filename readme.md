# stfrunner

Stfrunner tests command line programs.  It runs Single Test File (stf)
files.

An stf file contains one test.  It contains instructions for creating
files, running files and comparing files and it is designed to look
good in a markdown reader. For more detailed information see the
stfrunner help message.

Stfrunner is a spinoff of the statictea project which contains many
stf files you can learn from.  

* See the stfrunner stf-files folder for examples.
* [StaticTea Stf Files](https://github.com/flenniken/statictea/blob/master/testfiles/stf-index.md) -- See example Statictea stf files in the statictea project.

# Build

Stfrunner is a standalone exe. You build it in a docker
environment. You create the environment with the runenv command. You
build stfrunner exe with the build command.

* pull code
* runenv build
* runenv run
* build build
* build test

<style>body { max-width: 40em}</style>
