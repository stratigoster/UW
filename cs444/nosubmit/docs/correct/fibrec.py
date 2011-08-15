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
class _numeric_error(Exception):pass
class _constraint_error(Exception):pass
class main:
	try:
		def _1_fib(self,i):
			try:
				pass
				if ((i['all'] == 1) | (i['all'] == 2)):
					return 1
				else:
					return (self._1_fib(i = {'all':(i['all'] - 1)}) + self._1_fib(i = {'all':(i['all'] - 2)}))
			except _dummy_:
				pass
		num = { 'all':0 }
		def __init__(self):
			try:
				pass
				print 'Please enter a number: ',
				self.num['all'] = int(input()) 
				print '\nThe ',
				print self.num['all'],
				print 'th fibonacci number is ',
				print self._1_fib(i = {'all':self.num['all']}),
				print '\n',
			except _dummy_:
				pass
	except _dummy_:
		pass
main()
