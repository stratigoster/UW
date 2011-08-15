#include "Building.h"
#include "Room.h"
#include <iostream>

Building::Building( std::ifstream & input ) {
    std::string name;
    int numRooms = 0;
    input >> numRooms;
    for ( int i = 0; i < numRooms; i += 1 ) {
        input >> name;
        rooms[ name ] = new Room( input );
    } // for
} // Building::Building

Building::~Building() {
    for ( std::map<std::string, Room*>::const_iterator i = rooms.begin(); i != rooms.end(); i++ ) {
        delete i->second;
    } // for
} // Building::~Building

std::map<std::string, Room*>::iterator Building::find( std::string roomName ) {
    std::map<std::string, Room*>::iterator position;
    for ( position = rooms.begin(); position != rooms.end(); position++ ) {
        if ( position->first == roomName ) return position;
    } // for
    return position;
} // Building::find

Booking * Building::find( std::string roomName, int bookingNumber ) {
    std::map<std::string, Room*>::iterator position;
    position = find( roomName );
    if ( position != rooms.end() ) {
        Booking * booking = position->second->find( bookingNumber );
        if ( booking != NULL ) return booking;
    } // if
    return NULL;
} // Building::find

void Building::add( std::string roomName, Booking * booking ) {
    std::map<std::string, Room*>::iterator position;
    position = find( roomName );
    if ( position != rooms.end() ) {
        rooms[ roomName ]->add( booking );
    } // if
} // Building::add             

void Building::add( std::string roomName, Booking * booking, Time * time ) {
    std::map<std::string, Room*>::iterator position;
    position = find( roomName );
    if ( position != rooms.end() ) {
        rooms[ roomName ]->add( booking, time );
    } // if
} // Building::add

void Building::remove( std::string roomName, Booking * booking ) {
    std::map<std::string, Room*>::iterator position;
    position = find( roomName );
    if ( position != rooms.end() ) {
        rooms[ roomName ]->remove( booking );
    } // if
} // Building::remove         

void Building::remove( std::string roomName, Booking * booking, Time * time ) {
    std::map<std::string, Room*>::iterator position;
    position = find( roomName );
    if ( position != rooms.end() ) {
        rooms[ roomName ]->remove( booking, time );
    } // if
} // Building::remove

void Building::extractBookings( std::ofstream & output ) {
    std::map<std::string, Room*>::iterator position;
    output << rooms.size() << std::endl;
    for ( position = rooms.begin(); position != rooms.end(); position++ ) {
        output << position->first << std::endl;
        position->second->extractBookings( output );
    } // for
} // Building::extractBookings

void Building::listAllFreeRooms( Period *period ) {
    for ( std::map<std::string, Room*>::const_iterator i = rooms.begin(); i != rooms.end(); i++ ) {
        if ( i->second->isFree( period ) ) std::cout << i->first << std::endl;
    } // for
} // Building::listAllFreeRooms

std::ostream & operator<<( std::ostream & output, const Building & b ) {
    std::map<std::string, Room*>::const_iterator i;
    for ( i = b.rooms.begin(); i != b.rooms.end(); i++ ) {
        output << '\t' << i->first << " " << *(i->second);
    } // for
    return output;
} // operator<<

std::ostream & operator<<( std::ostream & output, const Building * b ) {
    std::map<std::string, Room*>::const_iterator i;
    for ( i = b->rooms.begin(); i != b->rooms.end(); i++ ) {
        output << '\t' << i->first << " " << *(i->second);
    } // for
    return output;
} // operator<<
