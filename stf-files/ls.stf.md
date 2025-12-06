stf file, version 0.1.0

# ls example

Example stf file that runs ls.

### File cmd.sh command

~~~
ls -1 >stdout 2>stderr
~~~

### File stdout.expected

~~~
cmd.sh
stderr
stdout
stdout.expected
~~~

### Expected stdout == stdout.expected
### Expected stderr == empty
