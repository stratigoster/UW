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
class _5(Exception):pass
class _3(Exception):pass
class _numeric_error(Exception):pass
class _constraint_error(Exception):pass
class main:
	try:
		def _2_isprime(self,i):
			try:
				pass
				if (i['all'] < 0):
					i['all'] = abs(i['all']) 
				if ((i['all'] == 0) or (i['all'] == 1)):
					return 0
				elif (i['all'] == 2):
					return 1
				else:
					try:
						for zzz in _forwardGen(range(2,(i['all'] - 1)+1)):
							if ((i['all'] % zzz['all']) == 0):
								return 0
					except _dummy_:
						pass
					return 1
			except _dummy_:
				pass
		def _1_genprimes(self,i):
			try:
				pass
				def _4():
					try:
						pass
						zzz = { 'all':1 }
						try:
							while (i['all'] >0):
								pass
								if self._2_isprime(i = {'all':zzz['all']}):
									i['all'] = (i['all'] - 1) 
									print zzz['all'],
									print ' ',
								zzz['all'] = (zzz['all'] + 1) 
						except _5:
							pass
					except _dummy_:
						pass
				_4()
			except _dummy_:
				pass
		num = { 'all':0 }
		def __init__(self):
			try:
				pass
				print 'Please enter a number: ',
				self.num['all'] = int(input()) 
				print '\nThe first ',
				print self.num['all'],
				print ' prime numbers are:\n',
				self._1_genprimes(i = {'all':self.num['all']})
				print '\n',
			except _dummy_:
				pass
	except _dummy_:
		pass
main()
