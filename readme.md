# stfrunner

Stfrunner tests command line programs.  It runs Single Test File (stf)
files.

An stf file contains one test.  It contains instructions for creating
files, running files and comparing files and it is designed to look
good in a markdown reader. For more detailed information see the
stfrunner help message.

Stfrunner is a spinoff of the statictea project which contains many
stf files you can learn from.  

* [StaticTea Stf Files](https://github.com/flenniken/statictea/blob/master/testfiles/stf-index.md) -- See example Statictea stf files in the statictea project.

See the stfrunner stf-files folder for examples. Here are a few:

* [Version Number](stf-files/version.stf.md) -- get version number
* [Md5sum Command](stf-files/md5.stf.md) -- run md5sum
* [Ls Command](stf-files/ls.stf.md) -- run ls
* [No Filename](stf-files/nofilearg.stf.md) -- specify -f without a filename

# Build

Stfrunner is a standalone exe. You build it in a docker
environment. You create the environment with the runenv command. You
build stfrunner exe with the build command.

* pull code
* runenv build
* runenv run
* build build
* build test

## Pull Code

~~~
mkdir -p ~/code/stfrunner
cd ~/code/stfrunner
git clone git@github.com:flenniken/stfrunner.git .
~~~

## Build Dev Environment

Build the docker development environment by running the runenv command:

~~~
./runenv b
~~~

## Run Dev Environment

Run the docker development environment by running the runenv command:

~~~
./runenv r
~~~

## Compile Nim

The first time you run the docker container you need to compile nim.

~~~
# inside docker container
cd ~/Nim
./build_all.sh
~~~

## Build Stfrunner

~~~
# inside docker container
b b
~~~

## Test Stfrunner

~~~
# inside docker container
b t
~~~

# Run Stf Files

~~~
# inside docker container
b stf
~~~

<style>body { max-width: 40em}</style>
