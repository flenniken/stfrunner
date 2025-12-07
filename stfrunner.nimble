include src/version

version       = stfrunnerVersion
author        = "Steve Flenniken"
description   = "A single test file runner."
license       = "MIT"
srcDir        = "src"
bin           = @["bin/debian/stfrunner"]

requires "nim >= 2.2.4"
