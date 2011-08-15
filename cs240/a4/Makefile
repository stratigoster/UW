CXXFLAGS=-g -Wall
CXX=g++

all: HEncode HDecode

HEncode: HEncode.cc
	$(CXX) $(CXXFLAGS) -o HEncode HEncode.cc

HDecode: HDecode.cc
	$(CXX) $(CXXFLAGS) -o HDecode HDecode.cc

clean:
	rm *.o HEncode HDecode
