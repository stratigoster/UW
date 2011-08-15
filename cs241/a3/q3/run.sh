#!/bin/sh
name=`basename $1 .sl`
java tok $name > temp
diff temp ${name}.out 
