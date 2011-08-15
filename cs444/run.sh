#!/bin/bash
NYAC=./nyac
TESTDIR=tests/
SUFFIX=.ada
OUT=.out
OUTPUT=output
BAR="--------------------------------------------------------------------------------"

if [[ -n $1 ]] && [[ $1 = "-r" ]]; then
  for x in $TESTDIR/test*$SUFFIX; do
    echo "Testing $x";
    $NYAC $x > ${TESTDIR}/`basename $x $SUFFIX`$OUT
    if [[ -f a.out ]]; then
      cat a.out >> ${TESTDIR}/`basename $x $SUFFIX`$OUT
    fi
  done
fi

if [[ -n $1 ]]; then
  if [[ $1 = "-v" || $1 = "-r" ]]; then
    rm -f $OUTPUT
    for x in $TESTDIR/test*$SUFFIX; do
      # FILE CONTENTS
      echo $BAR >> $OUTPUT
      echo `basename $x` >> $OUTPUT
      echo $BAR >> $OUTPUT
      cat $x >> $OUTPUT

      # OUTPUT FROM TEST
      echo $BAR >> $OUTPUT
      echo "RESULTS" >> $OUTPUT
      echo $BAR >> $OUTPUT
      cat ${TESTDIR}/`basename $x $SUFFIX`$OUT >> $OUTPUT
      
      # Print some newlines to make it look cool
      for x in `jot 3`; do
        echo >> $OUTPUT
      done
    done
  fi
else
  echo "Usage: `basename $0` [OPTIONS]"
  echo -e "  -r Runs all test cases and combines the output"
  echo -e "  -v Only combines all the .out files with the .ada files"
fi
