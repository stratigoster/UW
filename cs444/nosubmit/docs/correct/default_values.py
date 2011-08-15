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
		def _1_defaults(self):
			try:
				pass
				def _2():
					try:
						pass
						index = { 'all':0 }
						animal_sum = { 'all':0 }
						def _3_animals(total,cows,pigs,dogs):
							try:
								pass
								total['all'] = ((cows['all'] + pigs['all']) + dogs['all']) 
								print 'Cows =',
								print cows['all'],
								print '   Pigs =',
								print pigs['all'],
								print '   Dogs =',
								print dogs['all'],
								print '   and they total',
								print total['all'],
								print '\n',
							except _dummy_:
								pass
						index['all'] = 3 
						_3_animals(total = {'all':animal_sum['all']},
                cows = {'all':2},pigs = {'all':3},dogs = {'all':4})
						_3_animals(total = {'all':animal_sum['all']},
                cows = {'all':3},
                pigs = {'all':index['all']}
                ,dogs = {'all':4})
						_3_animals(total = {'all':animal_sum['all']},
                cows = {'all':0},
                pigs = {'all':0},
                dogs = {'all':4})
						_3_animals(total = {'all':animal_sum['all']},
                cows = {'all':5},
                pigs = {'all':((2 * index['all']) + 1)},
                dogs = {'all':0})
						_3_animals(total = {'all':animal_sum['all']},
                cows = {'all':0},
                pigs = {'all':0},
                dogs = {'all':(index['all'] + 4)})
						_3_animals(total = {'all':animal_sum['all']},
                cows = {'all':2},
                pigs = {'all':index['all']},
                dogs = {'all':4})
						_3_animals(total = {'all':animal_sum['all']},
                cows = {'all':0},
                pigs = {'all':0},
                dogs = {'all':0})
					except _dummy_:
						pass
				_2()
			except _dummy_:
				pass
		def __init__(self):
			try:
				pass
				self._1_defaults()
			except _dummy_:
				pass
	except _dummy_:
		pass
main()
