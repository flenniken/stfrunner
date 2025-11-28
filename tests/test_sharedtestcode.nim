import std/unittest
import sharedtestcode


suite "sharedtestcode.nim":

  test "gotExpected":
    check gotExpected("hello", "hello") == true
    
  # proc gotExpected*(got: string, expected: string, message = ""): bool =




