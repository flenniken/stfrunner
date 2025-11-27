stf file, version 0.1.0

# stfrunner help message when nothing specified.

### File cmd.sh command

~~~
$stfrunner -h >stdout 2>stderr
~~~

### File check.help command

~~~
head -3 stdout > top
~~~

### File top.expected

~~~
# Stf Runner

A program to test command line programs.
~~~

### Expected top == top.expected
### Expected stderr == empty
