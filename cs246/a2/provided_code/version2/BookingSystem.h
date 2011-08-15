#ifndef __SYSTEM_H
#define __SYSTEM_H

#include <map>
#include <string>
#include "Booking.h"
#include "Building.h"

class BookingSystem {
    std::map< std::string, Building *> buildings;

    friend std::ostream & operator<<( std::ostream &, const BookingSystem & );
    std::map< std::string, Building *>::iterator find( std::string );

  public:
    BookingSystem(int &);
    ~BookingSystem();
    Booking * find( std::string buildingName, std::string roomName,
            int bookingNumber );
    void add( std::string buildingName, std::string roomName,
          Booking *booking );
    void add( std::string buildingName, std::string roomName, Booking *booking,
          Time *time );
    void remove( std::string buildingName, std::string roomName,
         Booking *booking );
    void remove( std::string buildingName, std::string roomName,
         Booking *booking, Time *time );
    void listAllFreeRooms( std::string buildingName, Period *period );
    void listAllFreeRooms( Period *period );
};

#endif
