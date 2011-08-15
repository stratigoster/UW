#!/bin/ksh
echo "Enter the name of the SL program: \c"
read file
rm -f ${file}.mips ${file}.mo ${file}.mx
if java Main ${file}.sl
then
	echo "${file}.mips"
	cat ${file}.mips
	echo "*** Do you want to continue? (y/n) \c"
	read ans
	if [ $ans == "n" ]
	then
		exit 0
	else
		echo "*** assembling"
		java mips.asm ${file}
		java mips.lnk ${file} ${file}
		echo "*** executing"
		java mips.cpu $file
	fi
fi
exit 0
