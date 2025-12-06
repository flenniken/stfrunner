## Regular expression matching.

import std/nre
import std/options

const
  maxGroups = 10
    ## The maximum number of groups supported in the matchPattern
    ## procedure.

type
  CompiledPattern* = Regex
    ## A compiled regular expression.

type
  Matches* = object
    ## Holds the result of a match.
    ## * groups — list of matching groups
    ## * length — length of the match
    ## * start — where the match started
    ## * numGroups — number of groups
    groups*: seq[string]
    length*: Natural
    start*: Natural
    numGroups*: Natural

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
  result = Matches(groups: groups, length: length, start: start, numGroups: 1)

func newMatches*(length: Natural, start: Natural,
    group1: string, group2: string): Matches =
  ## Create a new Matches object with two groups.
  var groups = @[group1, group2]
  result = Matches(groups: groups, length: length, start: start, numGroups: 2)

proc newMatches*(length: Natural, start: Natural, groups: seq[string]): Matches =
  ## Create a Matches object with the given number of groups.
  result = Matches(length: length, start: start, groups: groups,
                   numGroups: groups.len)

func getGroupLen*(matchesO: Option[Matches]): (string, Natural) =
  ## Get the one group in matchesO and the match length.
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
  ## Return the number of groups specified. If one of the groups doesn't
  ## exist, "" is returned for it.
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

func matchRegex*(str: string, regex: CompiledPattern, start: Natural,
    numGroups: Natural): Option[Matches] =
  ## Match a regular expression pattern in a string. Start is the
  ## index in the string to start the search. NumGroups is the number
  ## of groups in the pattern. The pattern is anchored.
  if start >= str.len:
    return
  if numGroups > maxGroups:
    return

  # Use anchored matching: check if pattern matches from start position
  if start < str.len:
    let substr = str[start .. ^1]
    let matchResult = match(substr, regex)
    if matchResult.isSome:
      let m = matchResult.get()
      let matchStr = m.match
      let matchLength = matchStr.len
      if numGroups == 0:
        result = some(newMatches(matchLength, start))
      else:
        var groups: seq[string]
        for ix in 0 .. numGroups-1:
          try:
            groups.add(m.captures[ix])
          except:
            groups.add("")
        result = some(newMatches(matchLength, start, groups))

func compilePattern*(pattern: string): Option[CompiledPattern] =
  ## Compile the pattern and return a regex object.
  ## Note: the pattern uses the anchored option.
  try:
    let regex = re(pattern)
    result = some(regex)
  except CatchableError:
    result = none(CompiledPattern)

func matchPattern*(str: string, pattern: string,
    start: Natural, numGroups: Natural): Option[Matches] =
  ## Match a regular expression pattern in a string. Start is the
  ## index in the string to start the search. NumGroups is the number
  ## of groups in the pattern. The pattern is anchored.
  # If pattern starts with ^ (beginning anchor) and start > 0, it cannot match
  if pattern.len > 0 and pattern[0] == '^' and start > 0:
    return
  let regexO = compilePattern(pattern)
  if not regexO.isSome:
    return
  result = matchRegex(str, regexO.get(), start, numGroups)

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
    let regex = regexO.get()
    resultStr = replace(resultStr, regex, r.sub)
  result = some(resultStr)
