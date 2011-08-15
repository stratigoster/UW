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
		def _1_default2(self):
			try:
				pass
				def _2():
					try:
						pass
						index = { 'all':0 }
						animal_sum = { 'all':0 }
						def _3_cow_constant():
							try:
								pass
								return 7
							except _dummy_:
								pass
						def _4_pig_constant():
							try:
								pass
								animals = { 'all':(_3_cow_constant() - 3) }
								return ((2 * animals['all']) + 5)
							except _dummy_:
								pass
						def _5_animals(total,cows,pigs,dogs):
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
						_5_animals(total = {'all':animal_sum['all']},
                cows = {'all':2},
                pigs = {'all':3},
                dogs = {'all':4})
						_5_animals(total = {'all':animal_sum['all']},
                cows = {'all':2},
                pigs = {'all':index['all']},
                dogs = {'all':4})
						_5_animals(total = {'all':animal_sum['all']},
                cows = {'all':(2 * _3_cow_constant())},
                pigs = {'all':(_3_cow_constant() + _4_pig_constant())},
                dogs = {'all':4})
						_5_animals(total = {'all':animal_sum['all']},
                cows = {'all':5},
                pigs = {'all':((2 * index['all']) + 1)},
                dogs = {'all':0})
						_5_animals(total = {'all':animal_sum['all']},
                cows = {'all':(2 * _3_cow_constant())},
                pigs = {'all':(_3_cow_constant() + _4_pig_constant())},
                dogs = {'all':(index['all'] + 4)})
						_5_animals(total = {'all':animal_sum['all']},
                cows = {'all':2},
                pigs = {'all':index['all']},
                dogs = {'all':4})
						_5_animals(total = {'all':animal_sum['all']},
                cows = {'all':(2 * _3_cow_constant())},
                pigs = {'all':(_3_cow_constant() + _4_pig_constant())},
                dogs = {'all':0})
					except _dummy_:
						pass
				_2()
			except _dummy_:
				pass
		def __init__(self):
			try:
				pass
				self._1_default2()
			except _dummy_:
				pass
	except _dummy_:
		pass
main()
