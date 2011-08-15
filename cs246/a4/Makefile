CXXFLAGS=-g -Wall -DDEBUG
CXX=g++

# List of partially-compiled files to create.
OBJS= Controller.o LoggerState.o SimpleState.o Service.o SortService.o StorageService.o Main.o

system: $(OBJS)
	$(CXX) $(CXXFLAGS) -o system $(OBJS) 

clean:
	rm *.o system
