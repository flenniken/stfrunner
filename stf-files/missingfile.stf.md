stf file, version 0.1.0

# Test running with a missing file.

### File cmd.sh command nonZeroReturn

# No filename specified.
~~~
$stfrunner -f missing.stf >stdout 2>stderr
~~~

### File stdout.expected

~~~
File not found: 'missing.stf'.
~~~

### Expected stdout == stdout.expected
### Expected stderr == empty
