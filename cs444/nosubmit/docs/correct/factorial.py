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
class _3(Exception):pass
class _numeric_error(Exception):pass
class _constraint_error(Exception):pass
class main:
	try:
		start = { 'all':-2 }
		stop = { 'all':5 }
		result = { 'all':0 }
		data_value = { 'all':0 }
		def _2_factorial(self,number):
			try:
				pass
				if (not self._1_factorial_possible(number = {'all':number['all']})):
					print 'Factorial not possible for',
					print number['all'],
					print '\n',
					return 0
				if (number['all'] == 0):
					return 1
				elif (number['all'] == 1):
					return 1
				else:
					return (self._2_factorial(number = {'all':(number['all'] - 1)}) * number['all'])
			except _dummy_:
				pass
		def _1_factorial_possible(self,number):
			try:
				pass
				if (number['all'] >= 0):
					return 1
				else:
					return 0
			except _dummy_:
				pass
		def __init__(self):
			try:
				pass
				print 'Factorial program',
				print '\n',
				try:
					for number_to_try in _forwardGen(range(self.start['all'],self.stop['all']+1)):
						print number_to_try['all'],
						if self._1_factorial_possible(number = {'all':number_to_try['all']}):
							self.result['all'] = self._2_factorial(number = {'all':number_to_try['all']}) 
							print ' is legal to factorialize and the result is',
							print self.result['all'],
						else:
							print ' is not legal to factorialize.',
						print '\n',
				except _dummy_:
					pass
				print '\n',
				self.data_value['all'] = 4 
				self.result['all'] = self._2_factorial(number = {'all':(2 - self.data_value['all'])}) 
				self.result['all'] = self._2_factorial(number = {'all':(self.data_value['all'] + 3)}) 
				self.result['all'] = self._2_factorial(number = {'all':((2 * self.data_value['all']) - 3)}) 
				self.result['all'] = self._2_factorial(number = {'all':self._2_factorial(number = {'all':3})}) 
				self.result['all'] = self._2_factorial(number = {'all':4}) 
				self.result['all'] = self._2_factorial(number = {'all':0}) 
			except _dummy_:
				pass
	except _dummy_:
		pass
main()
