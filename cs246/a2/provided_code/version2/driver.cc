#include "BookingSystem.h"
#include "Booking.h"
#include "Date.h"
#include "Booking.h"
#include "Period.h"
#include <iostream>
#include <string>

void printMessage() {
    std::cout << "Commands are:" << std::endl;
    std::cout << "\th (help i.e., list all commands)" << std::endl;
    std::cout << "\tc (create a booking)" << std::endl;
    std::cout << "\ta (add to a booking)" << std::endl;
    std::cout << "\td (remove a booking)" << std::endl;
    std::cout << "\tr (remove a time period from a booking)" << std::endl;
    std::cout << "\tf (find a free room)" << std::endl;
    std::cout << "\tp (print the contents of the system)" << std::endl;
    std::cout << "\tq (quit; could use Ctrl-d)" << std::endl;
} // printMessage

void getBookingInfo( std::string & buildingName, std::string & roomName, 
             std::string & contactName ) 
{
    std::cout << "Enter the building name e.g. MC:" << std::endl;
    std::cin >> buildingName;
    std::cout << "Enter the room name e.g. MC4045:" << std::endl;
    std::cin >> roomName;
    std::cout << "Enter the contact name" << std::endl;
    std::cin >> contactName;
} // getBookingInfo

void getBookingInfo( std::string & buildingName, std::string & roomName, 
             int & bookingNumber ) 
{
    std::cout << "Enter the building name e.g. MC:" << std::endl;
    std::cin >> buildingName;
    std::cout << "Enter the room name e.g. MC4045:" << std::endl;
    std::cin >> roomName;
    std::cout << "Enter the booking number e.g. 1015" << std::endl;
    std::cin >> bookingNumber;
} // getBookingInfo

Period * getPeriodInfo() {
    int year, month, day, hour, minute;

    for ( ;; ) {
        std::cout << "\tEnter the starting year, month, day, hour and minute" 
              << " e.g. 2005 10 19 14 30" << std::endl;
        std::cin >> year >> month >> day >> hour >> minute;
        Instant start( hour, minute, Date( year, month, day ) );
        std::cout << "\tEnter the ending year, month, day, hour and minute " 
              << "e.g. 2005 10 19 17 30" << std::endl;
        std::cin >> year >> month >> day >> hour >> minute;
        Instant end( hour, minute, Date( year, month, day ) );
        if ( start < end ) {
            return ( new Period( start, end ) );
        } // if
        std::cout << "Invalid range of times. Starting time must be less than" 
              << " ending time" << std::endl;
    } // for    
} // getPeriodInfo

int main() {
    char            command;
    std::string     buildingName, roomName, contactName;
    int             numEvents, bookingNumber;
    int		    bookingID(0);
    Period        * period;
    Booking       * booking;
    BookingSystem   system(bookingID);

    std::cout << "Welcome to the room booking system." << std::endl;
    printMessage();

    for ( ;; ) {
        std::cout << "> ";
        std::cin >> command;
        if ( std::cin.eof() || command == 'q' ) break;

        switch ( command ) {
          case 'h':
              printMessage();
              break;
    
          case 'c':
              numEvents = 0;
              getBookingInfo( buildingName, roomName, contactName );
              std::cout << "Enter the number of time periods for this booking:" << std::endl;
              std::cin >> numEvents;
              for ( int i = 1; i <= numEvents; i += 1 ) {
                  std::cout << "Time period " << i << std::endl;
                  period = getPeriodInfo();
                  if ( i == 1 ) {
                      booking = new Booking( contactName, period,
			      bookingID++ );
                  } else {
                      booking->add( period );
                  } // if
              } // for
              system.add( buildingName, roomName, booking );
              break;

          case 'a':
              numEvents = 0;
              getBookingInfo( buildingName, roomName, bookingNumber );
              booking = system.find( buildingName, roomName, bookingNumber );
              if ( booking != NULL ) {
                  std::cout << "Enter the number of time periods to add to this" 
                        << " booking:" << std::endl;
                  std::cin >> numEvents;
                  for ( int i = 1; i <= numEvents; i += 1 ) {
                      std::cout << "Time period " << i << std::endl;
                      period = getPeriodInfo();
                      system.add( buildingName, roomName, booking, period );
                  } // for  
              } else {
                  std::cout << "Could not find a booking with number " 
                        << bookingNumber << " for room " << roomName 
                        << " in building " << buildingName << std::endl;
              } // if
              break;

          case 'd':
              getBookingInfo( buildingName, roomName, bookingNumber );
              booking = system.find( buildingName, roomName, bookingNumber );
              if ( booking != NULL ) {
                  system.remove( buildingName, roomName, booking );
              } else {
                  std::cout << "Could not find a booking with number " 
                        << bookingNumber << " for room " << roomName 
                        << " in building " << buildingName << std::endl;
              } // if
              break;
    
          case 'r':
              getBookingInfo( buildingName, roomName, bookingNumber );
              booking = system.find( buildingName, roomName, bookingNumber );
              if ( booking != NULL ) {
                  std::cout << "Enter the number of time periods to remove from" 
                        << " this booking:" << std::endl;
                  std::cin >> numEvents;
                  for ( int i = 1; i <= numEvents; i += 1 ) {
                      std::cout << "Time period " << i << std::endl;
                      period = getPeriodInfo();
                      system.remove( buildingName, roomName, booking, period );
                  } // for
              } else {
                  std::cout << "Could not find a booking with number " 
                        << bookingNumber << " for room " << roomName 
                        << " in building " << buildingName << std::endl;
              } // if
              break;

          case 'f':
              std::cout << "Specify the period over which you want to search." 
                    << std::endl;
              period = getPeriodInfo();
              std::cout << "Do you wish to search all buildings, or a specific" 
                    << " building?\nAnswer either \"all\", or the building"
                    << " code, without quotation marks." << std::endl;
              std::cin >> buildingName;
              if ( buildingName == "all" ) {
                  system.listAllFreeRooms( period );
              } else {
                  system.listAllFreeRooms( buildingName, period );
              } // if
              break;

          case 'p':
              std::cout << system << std::endl;
              break;

          default:
              std::cout << "Unrecognized command '" << command << "'" << std::endl;
        } // switch
    } // for

    return 0;
} // main
