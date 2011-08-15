#!/bin/ksh
ln -sf /u/cs241/pub/a/3/test1/*.in .
ln -sf /u/cs241/pub/a/3/test1/*.out .
for file in *.in
do
	echo $file
	cat $file
	prefix=`basename $file .in`
	java Main < $file > my_${prefix}.out
	cmp -s "${prefix}.out" "my_${prefix}.out"
	if [ $? -eq 0 ]
	then
		echo "test passed"
	else
		echo "test failed\nexpected:\n`cat ${prefix}.out`\nbut got:\n`cat my_${prefix}.out`"
	fi
	rm $file ${prefix}.out my_${prefix}.out
done	
exit 0
