#include "Room.h"
#include "Booking.h"
#include "Equipment.h"
#include "DataProjector.h"
#include "OverheadProjector.h"
#include "Screen.h"
#include <iostream>

Room::Room( std::ifstream & input ) {
    int  numEquipment = 0;
    char typeEquipment;

    input >> capacity;
    input >> numEquipment;
    for ( int i = 0 ; i < numEquipment; i += 1 ) {
        input >> typeEquipment;
        if ( input.eof() ) break;
        switch( typeEquipment ) {
          case 'D':
              equipment.push_back( new DataProjector( *this ) );
              break;
          case 'O':
              equipment.push_back( new OverheadProjector( *this ) );
              break;
          case 'S':
              equipment.push_back( new Screen( *this ) );
              break;
          default:
              std::cerr << "Unrecognized type of equipment '" << typeEquipment 
                        << "'; value ignored." << std::endl;
        } // switch
    } // for
} // Room::Room

Room::~Room() {
    for ( int i = 0; i < equipment.size(); i += 1 ) {
        delete equipment[ i ];
    } // for
} // Room::~Room

std::vector<Booking*>::iterator Room::find( Booking * booking ) {
    std::vector<Booking*>::iterator position;
    for ( position = bookings.begin(); position != bookings.end(); position++ ) {
        if ( booking == *position ) break;
    } // for
    return position;
} // Room::find

Booking * Room::find( int bookingNumber ) {
    std::vector<Booking*>::iterator position;
    for ( position = bookings.begin(); position != bookings.end(); position++ ) {
        if ( bookingNumber == (*position)->getBookingNumber() ) return *position;
    } // for
    return NULL;
} // Room::find

void Room::add( Booking * booking ) {
    bookings.push_back( booking );
} // Room::add

void Room::add( Booking * booking, Time * time ) {
    std::vector<Booking*>::iterator position;
    position = find( booking );
    if ( position == bookings.end() ) {
        booking->add( time );
        bookings.push_back( booking );
    } else {
        (*position)->add( time );
    } // if
} // Room::add    

void Room::remove( Booking * booking ) {
    std::vector<Booking*>::iterator position;
    position = find( booking );
    if ( position != bookings.end() ) {
        bookings.erase( position );
    } // if
} // Room::remove

void Room::remove( Booking * booking, Time * time ) {
    std::vector<Booking*>::iterator position;
    position = find( booking );
    if ( position != bookings.end() ) {
        (*position)->remove( time );
    } // if
} // Room::remove

void Room::extractBookings( std::ofstream & output ) {
    output << bookings.size() << std::endl;
    if ( ! bookings.empty() ) {
        for ( int i = 0; i < bookings.size(); i += 1 ) {
            bookings[i]->extractBookings( output );
        } // for    
    } // if
} // Room::extractBookings
    
bool Room::isFree( Period * period ) {
    bool returnValue = true;
    if ( bookings.empty() ) return true;
    for ( int i = 0; i < bookings.size() && returnValue; i += 1 ) {
        returnValue = returnValue && bookings[i]->isFree( period );
    } // for
    return returnValue;
} // Room::isFree

std::ostream & operator<<( std::ostream & output, const Room & r ) {
    output << " [" << r.capacity << ", ";

    // shouldn't need this, but loop is being entered even when size() returned 0   
    if ( ! r.equipment.empty() ) {
        for ( int i = 0; i < ( r.equipment.size() - 1 ); i += 1 ) {
            output << r.equipment[ i ] << ", ";
        } // for
        if ( r.equipment.size() > 0 ) {
            output << r.equipment[ r.equipment.size()-1 ];
        } // if
    } // if
    output << "]\n";

    for ( int i = 0; i < r.bookings.size(); i += 1 ) {
        output << r.bookings[i];
    } // for        
    return output;     
} // operator<<

std::ostream & operator<<( std::ostream & output, const Room * r ) {
    output << " [" << r->capacity << ", ";

    // shouldn't need this, but loop is being entered even when size() returned 0   
    if ( ! r->equipment.empty() ) {
        for ( int i = 0; i < ( r->equipment.size() - 1 ); i += 1 ) {
            output << r->equipment[ i ] << ", ";
        } // for
        if ( r->equipment.size() > 0 ) {
            output << r->equipment[ r->equipment.size()-1 ];
        } // if
    } // if
    output << "]\n";

    for ( int i = 0; i < r->bookings.size(); i += 1 ) {
        output << r->bookings[i];
    } // for        
    return output;     
} // operator<<
