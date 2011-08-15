#!/bin/ksh
find /u3/npow -iname '*.mips' -exec echo '{}' \; -exec head -5 '{}' \;
