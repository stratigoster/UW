#!/usr/bin/env python
import math
def _forwardGen(seq):
	for i in seq:
		yield { 'all':i }
def _reverseGen(seq):
	i = len(seq)
	while i>0:
		i = i - 1
		yield { 'all':seq[i] }
class _dummy_(Exception):pass
class _2(Exception):pass
class _numeric_error(Exception):pass
class _constraint_error(Exception):pass
class main:
	try:
		def _1_divide_loop(self):
			try:
				pass
				divide_result = { 'all':0 }
				try:
					for index in _forwardGen(range(1,8+1)):
						print 'Index is',
						print index['all'],
						print ' and the answer is',
						divide_result['all'] = (25 / (4 - index['all'])) 
						print divide_result['all'],
						print '\n',
				except _dummy_:
					pass
			except _dummy_:
				pass
			except ZeroDivisionError:
				print ' Divide by zero error.\n',
		def __init__(self):
			try:
				pass
				print 'Begin program here.\n',
				self._1_divide_loop()
				print 'End of program.\n',
			except _dummy_:
				pass
	except _dummy_:
		pass
main()
