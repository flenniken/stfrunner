stf file, version 0.1.0

# Test running without specifying a file.

### File cmd.sh command nonZeroReturn

# No filename specified.
~~~
$stfrunner -f >stdout 2>stderr
~~~

### File stdout.expected

~~~
The option 'filename' requires an argument.
~~~

### Expected stdout == stdout.expected
### Expected stderr == empty
