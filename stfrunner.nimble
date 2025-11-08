import std/os
import std/strutils
import std/json
import std/nre
import std/strformat
import std/sets
import std/algorithm
include src/version

proc getHostDirName(): string =
  ## Return a directory name corresponding to the given nim hostOS
  ## name.  The name is good for storing host specific files, for
  ## example in the bin and env folders.  Current possible host
  ## values: "windows", "macosx", "linux", "netbsd", "freebsd",
  ## "openbsd", "solaris", "aix", "haiku", "standalone".

  case hostOS
  of "macosx":
    result = "mac"
  of "linux":
    # Use debian to match the env/debian folder name.
    result = "debian"
  # of "windows":
  #   result = "win"
  else:
    assert false, "add a new platform"

let hostDirName = getHostDirName()

version       = stfrunnerVersion
author        = "Steve Flenniken"
description   = "A single test file runner."
license       = "MIT"
srcDir        = "src"
bin           = @[fmt"bin/{hostDirName}/statictea"]

requires fmt"nim >= 2.2.4"

