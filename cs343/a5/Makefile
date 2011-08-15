-include montype

CXX = u++
CXXFLAGS = -g -Wall -Wno-unused-label -DVOTERTYPE_$(TYPE)
OBJECTS = printer.o voter.o tallyVotes.o driver.o
EXEC = vote

ifeq ($(MONTYPE),$(TYPE))
$(EXEC) : $(OBJECTS)
	$(CXX) $(CXXFLAGS) $(OBJECTS) -o $@
else
ifeq ($(TYPE),)
$(EXEC) : $(OBJECTS)
	$(CXX) $(CXXFLAGS) $(OBJECTS) -o $@
else
.PHONY : $(EXEC)
$(EXEC) :
	rm -f montype
	touch tallyVotes.h
	$(MAKE) TYPE=$(TYPE)
endif
endif

montype :
	echo "MONTYPE:=$(TYPE)" > montype

tallyVotes.o : tallyVotes.h printer.h voter.h tallyVotes$(TYPE).cc
	$(CXX) $(CXXFLAGS) -c tallyVotes$(TYPE).cc -o tallyVotes.o

tallyVotesAUTO.cc : AutomaticSignal.h
printer.o : printer.h voter.h
voter.o : voter.h printer.h tallyVotes.h
driver.o : printer.h voter.h tallyVotes.h

clean :
	rm -f $(OBJECTS) $(EXEC) montype
