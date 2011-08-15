CXXFLAGS=-g -Wall
CXX=g++

# List of partially-compiled files to create.
OBJS= Road.o Intersection.o Map.o main.o

system: $(OBJS)
	$(CXX) $(CXXFLAGS) -o system $(OBJS) 

clean:
	rm *.o system
