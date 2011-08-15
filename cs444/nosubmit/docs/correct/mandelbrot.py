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
class _2(Exception):pass
class _1(Exception):pass
class _numeric_error(Exception):pass
class _constraint_error(Exception):pass
class main:
	try:
		zoom = { 'all':90.0 }
		max = { 'all':55.0 }
		x0 = { 'all':0 }
		y0 = { 'all':0 }
		x2 = { 'all':0 }
		y2 = { 'all':0 }
		x = { 'all':0 }
		y = { 'all':0 }
		k = { 'all':0 }
		r = { 'all':0 }
		def __init__(self):
			try:
				pass
				print 'P3\n400 400\n255\n',
				try:
					for i in _forwardGen(range(1,400+1)):
						try:
							for j in _forwardGen(range(1,400+1)):
								self.x['all'] = ((float(j['all']) - (400.0 / 2.0)) / self.zoom['all']) 
								self.x0['all'] = self.x['all'] 
								self.y['all'] = ((float(i['all']) - (400.0 / 2.0)) / self.zoom['all']) 
								self.y0['all'] = self.y['all'] 
								self.k['all'] = self.max['all'] 
								try:
									while (self.k['all'] >0.0):
										pass
										self.k['all'] = (self.k['all'] - 1.0) 
										self.x2['all'] = (self.x['all'] ** 2) 
										self.y2['all'] = (self.y['all'] ** 2) 
										if ((self.x2['all'] + self.y2['all']) >= 4.0):
											raise _3
										self.y['all'] = (((2.0 * self.x['all']) * self.y['all']) + self.y0['all']) 
										self.x['all'] = ((self.x2['all'] - self.y2['all']) + self.x0['all']) 
								except _3:
									pass
								if (self.k['all'] >0.0):
									self.r['all'] = ((self.k['all'] / self.max['all']) * 255.0) 
									print (int(math.floor(self.r['all'])) % 95),
									print (int(math.floor(self.r['all'])) % 70),
									print int(math.floor(self.r['all'])),
								else:
									print 0,
									print 0,
									print 0,
						except _dummy_:
							pass
				except _dummy_:
					pass
			except _dummy_:
				pass
	except _dummy_:
		pass
main()
