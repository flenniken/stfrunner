stf file, version 0.1.0

# Missing File

Test the error message when running with a missing file.

### File cmd.sh command nonZeroReturn

The missing.stf file doesn't exist.

~~~
$stfrunner -f missing.stf >stdout 2>stderr
~~~

### File stdout.expected

~~~
File not found: 'missing.stf'.
~~~

### Expected stdout == stdout.expected
### Expected stderr == empty
