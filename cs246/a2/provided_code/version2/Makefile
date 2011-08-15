#CXXFLAGS=-g
CXX=g++

# List of partially-compiled files to create.
OBJS= Equipment.o DataProjector.o OverheadProjector.o \
      Screen.o Room.o Building.o BookingSystem.o \
      Booking.o Date.o Instant.o Period.o driver.o

system: $(OBJS)
	$(CXX) $(CXXFLAGS) -o system $(OBJS) 

clean:
	rm *.o system
