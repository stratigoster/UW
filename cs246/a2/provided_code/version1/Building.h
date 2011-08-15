#ifndef __BUILDING_H
#define __BUILDING_H

#include <string>
#include <map>
#include <fstream>
#include "Booking.h"
#include "Time.h"
#include "Period.h"

class Room;

class Building {
    std::map<std::string, Room*> rooms;

    std::map<std::string, Room*>::iterator find( std::string roomName );

  public:
    Building( std::ifstream & input );
    ~Building();

    Booking * find( std::string roomName, int bookingNumber );

    // Add a booking to the room.    
    void add( std::string roomName, Booking * booking );             

    // Add a time to the room's booking. 
    void add( std::string roomName, Booking * booking, Time * time );

    // Remove the room's booking.
    void remove( std::string roomName, Booking * booking );         

    // Remove a time from the room's booking.
    void remove( std::string roomName, Booking * booking, Time * time );

    // Extract bookings for building and send to file stream.
    void extractBookings( std::ofstream & output );

    void listAllFreeRooms( Period *period );
    std::string print();
};

#endif
