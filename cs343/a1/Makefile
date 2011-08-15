CXX=g++
CFLAGS=-O2

all: ifwhile ifwhile_orig

ifwhile: ifwhile.C
	$(CXX) $(CFLAGS) ifwhile.C -o ifwhile

ifwhile_orig: ifwhile_orig.C
	$(CXX) $(CFLAGS) ifwhile_orig.C -o ifwhile_orig

clean:
	rm -f ifwhile ifwhile_orig
