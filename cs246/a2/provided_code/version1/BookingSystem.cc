#include "BookingSystem.h"
#include <fstream>
#include <iostream>
#include "Period.h"
#include "Instant.h"

BookingSystem::BookingSystem(int & bookingID) {
    std::string    buildingName, roomName, contactName;
    int            numBuildings = 0, numRooms, numBookings;
    int            numPeriods, time, year, month, day;
    std::ifstream  inputBuildings( "buildings.txt" );
    std::ifstream  inputBookings( "bookings.txt" );
    Period       * period;
    Booking      * booking;

    inputBuildings >> numBuildings;
    for ( int i = 0; i < numBuildings; i += 1 ) {
        inputBuildings >> buildingName;
        buildings[ buildingName ] = new Building( inputBuildings );
    } // for

    inputBookings >> numBuildings;
    for ( int i = 0; i < numBuildings; i += 1 ) {
        inputBookings >> buildingName >> numRooms;
        for ( int j = 0; j < numRooms; j += 1 ) {
            inputBookings >> roomName >> numBookings;
            for ( int k = 0; k < numBookings; k += 1 ) {
                inputBookings >> contactName >> numPeriods;
                for ( int m = 0; m < numPeriods; m += 1 ) {
                    inputBookings >> time >> year >> month >> day;
                    Instant start( time / 100, time % 100, 
                    Date( year, month, day ) );
                    inputBookings >> time >> year >> month >> day;
                    Instant end( time / 100, time % 100, 
                    Date( year, month, day ) );
                    period = new Period( start, end );
                    if ( m == 0 ) {
                        booking = new Booking( contactName, period,
				bookingID++ );
                    } else {
                        booking->add( period );
                    } // if
                } // for
                add( buildingName, roomName, booking );
           } // for
        } // for    
    } // for
} // BookingSystem::BookingSystem

BookingSystem::~BookingSystem() {
    std::ofstream output( "bookings.txt" );
    std::map< std::string, Building *>::iterator position = buildings.begin();

    output << buildings.size() << std::endl;
    for ( ; position != buildings.end(); position++ ) {
        output << position->first << std::endl;
        position->second->extractBookings( output );
        delete position->second;
    } // for
} // BookingSystem::~BookingSystem

std::map< std::string, Building *>::iterator 
BookingSystem::find( std::string buildingName ) 
{
    std::map< std::string, Building *>::iterator position = buildings.begin();
    for ( ; position != buildings.end(); position++ ) {
        if ( buildingName == position->first ) break;
    } // for
    return position;
} // BookingSystem::find

Booking * BookingSystem::find( std::string buildingName, std::string roomName, 
                   int bookingNumber ) 
{
    std::map< std::string, Building *>::iterator position;
    position = find( buildingName );
    if ( position != buildings.end() ) {
        Booking *booking = position->second->find( roomName, bookingNumber );
        if ( booking != NULL ) return booking;
    } // if
    return NULL;
} // BookingSystem::find

void BookingSystem::add( std::string buildingName, std::string roomName, 
             Booking *booking ) 
{
    std::map< std::string, Building *>::iterator position;
    position = find( buildingName );
    if ( position != buildings.end() ) {
        position->second->add( roomName, booking );
    } // if
} // BookingSystem::add

void BookingSystem::add( std::string buildingName, std::string roomName, 
             Booking *booking, Time *time ) 
{
    std::map< std::string, Building *>::iterator position;
    position = find( buildingName );
    if ( position != buildings.end() ) {
        position->second->add( roomName, booking, time );
    } // if
} // BookingSystem::add

void BookingSystem::remove( std::string buildingName, std::string roomName, 
                Booking *booking ) 
{
    std::map< std::string, Building *>::iterator position;
    position = find( buildingName );
    if ( position != buildings.end() ) {
        position->second->remove( roomName, booking );
    } // if
} // BookingSystem::remove

void BookingSystem::remove( std::string buildingName, std::string roomName, 
                Booking *booking, Time *time ) 
{
    std::map< std::string, Building *>::iterator position;
    position = find( buildingName );
    if ( position != buildings.end() ) {
        position->second->remove( roomName, booking, time );
    } // if
} // BookingSystem::remove
    
void BookingSystem::listAllFreeRooms( std::string buildingName, 
                      Period *period ) 
{
    std::map< std::string, Building *>::iterator position;
    position = find( buildingName );
    if ( position != buildings.end() ) {
        position->second->listAllFreeRooms( period );
    } // if
} // BookingSystem::listAllFreeRooms
    
void BookingSystem::listAllFreeRooms( Period *period ) {
    std::map< std::string, Building *>::iterator position = buildings.begin();
    std::cout << "The rooms free for the period " << period->print() << " are:" << std::endl;
    for ( ; position != buildings.end(); position++ ) {
        position->second->listAllFreeRooms( period );
    } // for
} // BookingSystem::listAllFreeRooms

std::string BookingSystem::print() {
    std::string str;
    std::map< std::string, Building *>::iterator position = buildings.begin();
    for ( ; position != buildings.end(); position++ ) {
        str += position->first + position->second->print();
    } // for
    return str;
} // BookingSystem::print
