stf file, version 0.1.0

# md5sum version

Example stf file that tests that the md5sum program shows the version
when nothing is specified.

### File cmd.sh command

~~~
md5sum --version  >stdout 2>stderr
~~~

### File stdout.expected

~~~
md5sum (GNU coreutils) 9.1
Copyright (C) 2022 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <https://gnu.org/licenses/gpl.html>.
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

Written by Ulrich Drepper, Scott Miller, and David Madore.
~~~

### Expected stdout == stdout.expected
### Expected stderr == empty
