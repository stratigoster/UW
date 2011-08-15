#ifndef __ROOM_H
#define __ROOM_H

#include <string>
#include <vector>
#include <fstream>
#include "Time.h"
#include "Period.h"

class Equipment;
class Booking;

class Room {
    int                     capacity;
    std::vector<Equipment*> equipment;
    std::vector<Booking*>   bookings;

    std::vector<Booking*>::iterator find( Booking * booking );

  public:
    // Room and assigned equipment read in from iostream passed in.
    Room( std::ifstream & input );
    ~Room();

    Booking * find( int bookingNumber );
    
    // Add a booking to the room.    
    void add( Booking * booking );

    // Add a time to the room's booking. 
    void add( Booking * booking, Time * time );

    // Remove the room's booking.
    void remove( Booking * booking );

    // Remove a time from the room's booking.
    void remove( Booking * booking, Time * time );

    // Extract bookings for each room and send to file stream.
    void extractBookings( std::ofstream & output );

    bool isFree( Period * period );
    std::string print();
};

#endif
