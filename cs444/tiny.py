#!/usr/bin/env python
import math
class main:
	def foo(self,h):
		n = 989
		return h*(h-1)+(2.0*h*(n-h*h)/(2.0*h))+1.0-n
#		return h*(h-1)+(2*(n-h**2)/(2*h)+1)*h -n
	def __init__(self):
		pass
m = main()
print m.foo(23)
