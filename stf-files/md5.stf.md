stf file, version 0.1.0

# md5sum example

Example stf file that runs the md5sum program.

### File cmd.sh command

~~~
md5sum cmd.sh  >stdout 2>stderr
~~~

### File stdout.expected

~~~
32a0c5c7b284417424d2766f2fa0a70d  cmd.sh
~~~

### Expected stdout == stdout.expected
### Expected stderr == empty
