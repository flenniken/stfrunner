## Regular expression matching.
##
## Using the regex module:
## https://nitely.github.io/nim-regex/regex/nfatype.html

import regex
import std/options

type
  CompiledPattern* = Regex2
    ## A compiled regular expression.

type
  Matches* = object
    ## Holds the result of a match.
    ## * groups — list of matching group strings
    ## * length — total length of the match
    ## * start — where the match started
    groups*: seq[string]
    length*: Natural
    start*: Natural

  Replacement* = object
    ## Holds the regular expression pattern and its replacement for
    ## the replaceMany function.
    pattern*: string
    sub*: string

func newMatches*(length: Natural, start: Natural): Matches =
  ## Create a new Matches object with no groups.
  result = Matches(length: length, start: start)

func newMatches*(length: Natural, start: Natural, group: string): Matches =
  ## Create a new Matches object with one group.
  var groups = @[group]
  result = Matches(groups: groups, length: length, start: start)

func newMatches*(length: Natural, start: Natural,
    group1: string, group2: string): Matches =
  ## Create a new Matches object with two groups.
  var groups = @[group1, group2]
  result = Matches(groups: groups, length: length, start: start)

proc newMatches*(length: Natural, start: Natural, groups: seq[string]): Matches =
  ## Create a Matches object with the given number of groups.
  result = Matches(length: length, start: start, groups: groups)

proc newMatches*(str: string, match: RegexMatch2): Matches =
  ## Create a Matches object from a string and a RegexMatch2 object.

  # RegexMatch2 = object
  #   captures*: seq[Slice[int]]
  #   namedGroups*: OrderedTable[string, int16]
  #   boundaries*: Slice[int]

  let length = match.boundaries.b - match.boundaries.a + 1
  let start = match.boundaries.a
  var groups: seq[string] = @[]

  for s in match.captures:
    let groupStr = str[s.a .. s.b]
    groups.add(groupStr)

  result = Matches(length: length, start: start, groups: groups)

func getGroupLen*(matchesO: Option[Matches]): (string, Natural) =
  ## Return the match and match length for the first group.
  assert(matchesO.isSome, "Not a match")
  var one: string
  let matches = matchesO.get()
  if matches.groups.len > 0:
    one = matches.groups[0]
  result = (one, matches.length)

func get2GroupsLen*(matchesO: Option[Matches]): (string, string, Natural) =
  ## Get two groups and length in matchesO.
  assert(matchesO.isSome, "Not a match")
  let matches = matchesO.get()
  var one: string
  if matches.groups.len > 0:
    one = matches.groups[0]
  var two: string
  if matches.groups.len > 1:
    two = matches.groups[1]
  result = (one, two, matches.length)

func getGroups*(matchesO: Option[Matches], numGroups: Natural): seq[string] =
  ## Return the number of groups specified. If one of the groups
  ## doesn't exist, "" is returned for it. 10 is the maximum number of
  ## groups supported.
  let maxGroups = 10

  assert(matchesO.isSome, "Not a match")
  let matches = matchesO.get()
  if numGroups > maxGroups:
    return
  var groups = newSeqOfCap[string](numGroups)
  for ix in countUp(0, numGroups-1):
    if ix < matches.groups.len:
      groups.add(matches.groups[ix])
    else:
      groups.add("")
  result = groups

func matchRegex*(str: string, regex: CompiledPattern): Option[Matches] =
  ## Find a regular expression pattern in a string.
  var match = RegexMatch2()
  if find(str, regex, match):
    result = some(newMatches(str, match))

func compilePattern*(pattern: string): Option[CompiledPattern] =
  ## Compile the pattern for performance.
  try:
    let compiled = re2(pattern)
    result = some(compiled)
  except RegexError:
    result = none(CompiledPattern)

func matchPattern*(str: string, pattern: string): Option[Matches] =
  ## Match a regular expression pattern in a string.
  let regexO = compilePattern(pattern)
  if not regexO.isSome:
    return
  result = matchRegex(str, regexO.get())

func newReplacement*(pattern: string, sub: string): Replacement =
  ## Create a new Replacement object.
  result = Replacement(pattern: pattern, sub: sub)

proc replaceMany*(str: string, replacements: seq[Replacement]): Option[string] =
  ## Replace the patterns in the string with their replacements.

  var resultStr = str
  for r in replacements:
    let regexO = compilePattern(r.pattern)
    if not regexO.isSome:
      return
    let compiled = regexO.get()
    resultStr = replace(resultStr, compiled, r.sub, limit = 0)
  result = some(resultStr)
