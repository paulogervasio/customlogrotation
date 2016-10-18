# Customized Log Rotation
A customized log rotation script.
All files with a pre defined date, 60 days ago per default, will be joined in a single compressed file 
and removed from directory.

Will be util when your system storage is full and you not have any log system rotation configurated.



## Instructions to create new "old" files:

To realize your own tests just creates a simple file, file.txt for example, and issues this command:
```
touch -ma --date="2000-01-01 00:00:01" file.txt
```

This command will "reset" the file date to the 2001/01/01 at 00:00:01


to verify if the command was properly issued:
```
stat file.txt
```



Enjoy and have fun!


TODO
- insert customized path to compress files
- help screens
- option to insert old dates different from 60 days ago

