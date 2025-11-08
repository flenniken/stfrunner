import std/unittest
import matches
import version
import options

suite "version.nim":

  test "test me":
    check 1 == 1

  test "test version string":
    let matchesO = matchVersion(stfrunnerVersion)
    if not matchesO.isSome:
      echo "Invalid StaticTea version number: " & stfrunnerVersion
      fail
