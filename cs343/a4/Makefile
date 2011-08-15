CC=u++
JC=javac
CFLAGS=-Wall

all: searcher searcherJava smokers

searcher: searcher.cc
	$(CC) $(CFLAGS) searcher.cc -o searcher

searcherJava: Node.java Searcher.java Driver.java
	$(JC) Driver.java

smokers: smokers.cc smokers.h
	$(CC) $(CFLAGS) smokers.cc -o smokers

clean:
	rm -f searcher smokers Node.class Searcher.class Driver.class
