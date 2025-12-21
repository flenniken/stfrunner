import std/unittest
import version
import options
import regexes

const
  versionPattern = r"^([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})$"
  ## Stfrunner version regular expression pattern.  It has
  ## three components each with one to three digits: i.e. 1.2.3,
  ## 123.456.789, 0.1.0,... .

suite "version.nim":

  test "test version string":
    let regexO = compilePattern(versionPattern)
    assert regexO.isSome
    let matchesO = matchRegex(stfrunnerVersion, regexO.get())
    if not matchesO.isSome:
      echo "Invalid stfrunner version number: " & stfrunnerVersion
      fail
