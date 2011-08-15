-include datatype

CXX = u++
CXXFLAGS = -g -Wall -Wno-unused-label -DTYPE=$(DATATYPE) -DEND_OF_SET=$(END_OF_SET)
OBJECTS = driver.o
EXEC = binsertsort

ifeq ($(DATATYPE),$(TYPE))
$(EXEC) : $(OBJECTS)
	$(CXX) $(CXXFLAGS) $(OBJECTS) -o $@
else
ifeq ($(TYPE),)
$(EXEC) : $(OBJECTS)
	$(CXX) $(CXXFLAGS) $(OBJECTS) -o $@
else
.PHONY : $(EXEC)
$(EXEC) :
	rm -f datatype
	touch binsertsort.h
	$(MAKE) TYPE=$(TYPE) END_OF_SET=$(END_OF_SET)
endif
endif

datatype :
	echo "DATATYPE:=$(TYPE)" > datatype

driver.o: binsertsort.h

clean:
	rm -f $(OBJECTS) $(EXEC) datatype election

election: election.cc
	$(CXX) election.cc -o election
