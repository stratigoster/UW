#!/bin/ksh
for file in *.sl
do
	prefix=`basename $file .sl`
	java Main $prefix
	java mips.mak $prefix $prefix
	java mips.cpu $prefix > my_${prefix}.out
	cmp -s "${prefix}.out" "my_${prefix}.out"
	if [ $? -eq 0 ]
	then
		echo "test passed on $file"
	else
		echo "test failed on $file"
	fi
	rm my_${prefix}.out ${prefix}.mx ${prefix}.mo
done	
exit 0
