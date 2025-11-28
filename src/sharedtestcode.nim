## Shared test code.

when defined(test):
  import std/streams
  import std/os
  import std/times
  import std/options
  import std/strutils
  import linebuffer

  proc echoNewline(str: string) =
    ## Print a line to the screen and display the line endings as \n
    ## or \r\n.
    var newstr = str.replace("\r\n", r"\r\n")
    echo newstr.replace("\n", r"\n")

  proc readXLines*(lb: var LineBuffer, maxLines: Natural = high(Natural)): seq[string] =
    ## Read lines from a LineBuffer returning line endings but don't
    ## read more than the maximum number of lines. Reading starts at
    ## the current lb's current position and the position at the end
    ## is ready for reading the next line.
    var count = 0
    while true:
      if count >= maxLines:
        break
      var line = lb.readline()
      if line == "":
        break
      result.add(line)
      inc(count)

  proc readXLines*(stream: Stream,
    maxLineLen: int = defaultMaxLineLen,
    bufferSize: int = defaultBufferSize,
    filename: string = "",
    maxLines: Natural = high(Natural)
  ): seq[string] =
    ## Read all lines from a stream returning line endings but don't
    ## read more than the maximum number of lines.
    stream.setPosition(0)
    var lineBufferO = newLineBuffer(stream)
    if not lineBufferO.isSome:
      return
    var lb = lineBufferO.get()
    result = readXLines(lb, maxLines)

  proc readXLines*(filename: string,
    maxLineLen: int = defaultMaxLineLen,
    bufferSize: int = defaultBufferSize,
    maxLines: Natural = high(Natural)
  ): seq[string] =
    ## Read all lines from a file returning line endings but don't
    ## read more than the maximum number of lines.
    var stream = newFileStream(filename)
    if stream == nil:
      return
    result = readXLines(stream, maxLineLen, bufferSize, filename, maxLines)
    stream.close

  proc createFile*(filename: string, content: string) =
    ## Create a file with the given content.
    var file = open(filename, fmWrite)
    file.write(content)
    file.close()

  proc gotExpected*(got: string, expected: string, message = ""): bool =
    ## Return true when the got string matches the expected string,
    ## otherwise return false and show the differences.
    if got != expected:
      if message != "":
        echo message
      echo "     got: " & got
      echo "expected: " & expected
      return false
    return true

  proc expectedItem*[T](name: string, item: T, expectedItem: T): bool =
    ## Compare the item with the expected item and show them when
    ## different. Return true when they are the same.

    if item == expectedItem:
      result = true
    else:
      echo "$1" % name
      echoNewline "     got: $1" % $item
      echoNewline "expected: $1" % $expectedItem
      result = false

  proc expectedItems*[T](name: string, items: seq[T], expectedItems:
                         seq[T]): bool =
    ## Compare the items with the expected items and show them when
    ## different. Return true when they are the same.

    if items == expectedItems:
      result = true
    else:
      if items.len != expectedItems.len:
        echo "~~~~~~~~~~ $1 ($2)~~~~~~~~~~~:" % [name, $items.len]
        for item in items:
          echoNewline $item
        echo "~~~~~~ expected $1 ($2)~~~~~~:" % [name, $expectedItems.len]
        for item in expectedItems:
          echoNewline $item
      else:
        echo "~~~~~~~~~~ $1 ~~~~~~~~~~~:" % name
        for ix in 0 ..< items.len:
          if items[ix] == expectedItems[ix]:
            echoNewline "$1 (same):      got: $2" % [$ix, $items[ix]]
            echoNewline "$1 (same): expected: $2" % [$ix, $expectedItems[ix]]
          else:
            echoNewline "$1       :      got: $2" % [$ix, $items[ix]]
            echoNewline "$1       : expected: $2" % [$ix, $expectedItems[ix]]
      result = false
